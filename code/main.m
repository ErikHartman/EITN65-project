% Strong vs weak stimuli
% Strong + noise
% Strong + noise + lateral inhibition

%% generate data
% preallocate
N_train = 2000;
N_test = 1000; 
X_train = zeros(N_train, 35);
Y_train = zeros(N_train,1);
X_test = zeros(N_test, 35);
Y_test = zeros(N_test,1);

% Parameters
lateral_inhibition_flag = 0;
noise_flag = 0;
I = 10; % strong
% I = 1; % weak
nr_letters = 10;

for i = 1:N_train 
    if mod(i,20) == 0
        d = [num2str((100*i)/N_train), '%'];
        disp(d)
    end
    k = mod(i,nr_letters)+1;
    Y_train(i) = k;
    X_train(i,:) = simulateBraille(k, lateral_inhibition_flag, noise_flag, I); 
end
disp('Training set done')

for i = 1:N_test
    if mod(i,10) == 0
        d = [num2str((100*i)/N_test), '%'];
        disp(d)
    end
    k = mod(i,nr_letters)+1;
    Y_test(i) = k;
    X_test(i,:) = simulateBraille(k, lateral_inhibition_flag, noise_flag, I); 
end
disp('Test set done')

% Shuffle
[X_train, Y_train] = shuffle(X_train, Y_train);
[X_test, Y_test] = shuffle(X_test, Y_test);

save('strong_stim.mat', 'X_train','Y_train','X_test','Y_test')

%% PCA

load strong_stim_with_noise_and_LI.mat

[coeff, score, latent] = pca(X_train);
figure;
biplot(coeff(:,1:2),'scores',score(:,1:2), 'Marker','*');
figure;
hold on
subplot(2,1,1)
title('Component importance')
plot(latent/sum(latent),'*-')
subplot(2,1,2)
title('Cumulative sum')
plot(cumsum(latent/sum(latent)),'*-')
hold off

%% Input into SVM
SVM_model = fitcecoc(X_train,Y_train);
[label,~] = predict(SVM_model,X_test);
accuracy =  sum(Y_test == label)/N_test;
figure;
C = confusionchart(Y_test,label,'RowSummary','row-normalized','ColumnSummary','column-normalized');

%% SVM on PCA-results
X_train2 = X_train*coeff(:,1:5);
X_test2 = X_test*coeff(:,1:5);
SVM_model2 = fitcecoc(X_train2,Y_train);
[label2,~] = predict(SVM_model2,X_test2);
accuracy2 =  sum(Y_test == label2)/N_test;
figure;
C2 = confusionchart(Y_test,label2,'RowSummary','row-normalized','ColumnSummary','column-normalized');

%% functions
function [X,Y] = shuffle(X,Y)
    n = length(Y);
    idx = randperm(n);
    Y = Y(idx);
    X =  X(idx,:);
end


