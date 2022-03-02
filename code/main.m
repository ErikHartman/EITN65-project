% generate input stimuli for 2 characters ( to begin with ) 

% preallocate
N_train = 100;
N_test = 20; 
X_train = zeros(N_train, 35);
Y_train = zeros(N_train,1);
X_test = zeros(N_test, 35);
Y_test = zeros(N_test,1);

lateral_inhibition_flag = 1;
I = 10; % strong
% I = 1; % weak

% generate braille test and train set 
for i = 1:N_train 
    k = mod(i,4)+1;
    Y_train(i) = k;
    X_train(i,:) = simulateBraille(k, lateral_inhibition_flag, I); 
end
disp('Training set done')
for i = 1:N_test
    k = mod(i,4)+1;
    Y_test(i) = k;
    X_test(i,:) = simulateBraille(k, lateral_inhibition_flag, I); 
end
disp('Test set done')

% Shuffle
[X_train, Y_train] = shuffle(X_train, Y_train);
[X_test, Y_test] = shuffle(X_test, Y_test);

[coeff, score] = pca(X_train);
figure;
biplot(coeff(:,1:2),'scores',score(:,1:2), 'Marker','*');
figure;
plot(sum(coeff),'*-')

% Input into SVM
SVM_model = fitcecoc(X_train,Y_train);
[label,~] = predict(SVM_model,X_test);

accuracy =  sum(Y_test == label)/N_test;

function [X,Y] = shuffle(X,Y)
    n = length(Y);
    idx = randperm(n);
    Y = Y(idx);
    X =  X(idx,:);
end


