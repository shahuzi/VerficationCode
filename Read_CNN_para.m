% �˴������ľ���(weights)�ĸ�ʽΪ[out_channels,input_channels,filter_width,filter_height]
% ǡ����tensorflow��ת��


filename = 'params/CNN_parameters_2000_5.h5';
global conv1_biases;
global conv1_weights;
global conv2_biases;
global conv2_weights;
global local3_biases;
global local3_weights;
% global local4_biases;
% global local4_weights;
global softmax_weights;
global softmax_biases;

conv1_biases = h5read(filename,'/conv1/biases');
conv1_weights = h5read(filename,'/conv1/weights');
conv2_biases = h5read(filename,'/conv2/biases');
conv2_weights = h5read(filename,'/conv2/weights');
local3_biases = h5read(filename,'/local3/biases')';  % python��matlab ��Ҫת��
local3_weights = h5read(filename,'/local3/weights')';
% local4_biases = h5read(filename,'/local4/biases')';
% local4_weights = h5read(filename,'/local4/weights')';
softmax_weights = h5read(filename,'/softmax/weights')';
softmax_biases = h5read(filename,'/softmax/biases')';
