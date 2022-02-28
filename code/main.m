% generate input stimuli for 2 characters ( to begin with ) 

% preallocate
N_train = 100;
N_test = 20; 
X_train = zeros(N_train, 35);
Y_train = zeros(N_train,1);
X_test = zeros(N_test, 35);
Y_test = zeros(N_test,1);

% generate braille test and train set 
for i = 1:N_train 
    k = mod(i,4)+1;
    Y_train(i) = k;
    X_train(i,:) = simulateBraille(k); 
end
disp('Training set done')
for i = 1:N_test
    k = mod(i,4)+1;
    Y_test(i) = k;
    X_test(i,:) = simulateBraille(k); 
end
disp('Test set done')



[coeff, score] = pca(X_train);
figure;
biplot(coeff(:,1:2),'scores',score(:,1:2), 'Marker','*');
figure;
plot(sum(coeff),'*-')

% Input into SVM
SVM_model = fitcecoc(X_train,Y_train);
[label,~] = predict(SVM_model,X_test);

accuracy =  sum(Y_test == label)/N_test;


