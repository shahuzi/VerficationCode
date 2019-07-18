function out = CNN_ForwardFeed(image_batch)

%%
% CNN前向过程，网络结构c1-p1-c2-s2-f3-f4-softmax
% 输入:28*18*3
% c1: 卷积核：3*3 输入通道：3 输出通道：64 步长1*1 输出维度28*18*64 填充卷积
% s1: 最大池化 3*3 步长 2*2 输出维度 14*9*64 填充池化 局部响应归一化
% c2 卷积核：3*3 输入通道：64 输出通道：16 步长1*1 输出维度14*9*16 填充卷积
% s2 最大池化 3*3 步长 1*1 输出维度 14*9*64 填充池化 局部响应归一化
% s2之后，拉成一个14*9*64=2016的一维向量
% f3: 2016维全连接层，输出维度为128
% f4:输出也为128维
% softmax-输出为36维


% TransferData;  % 加载训练集
% Read_CNN_para;
% image = data(:,:,:,1);

% disp('Begin the forward process.......')

global conv1_biases;
global conv1_weights;
global conv2_biases;
global conv2_weights;
global local3_biases;
global local3_weights;
global local4_biases;
global local4_weights;
global softmax_weights;
global softmax_biases;

%% conv1 

% startmatlabpool(4);
[~,~,~,batch_size] = size(image_batch);
out_channel1 = 16;
out_channel2 = 8;
for batch=1:batch_size
    summary = zeros(28,18);
    conv1 = zeros(28,18,out_channel1);
    image = image_batch(:,:,:,batch);
    for out_channels=1:out_channel1
        for in_channels=1:1
            summary = summary +  conv2d_stride_1x1(image(:,:,in_channels),squeeze(conv1_weights(out_channels,in_channels,:,:))');
        end
        conv1(:,:,out_channels) = summary;
        summary=zeros(28,18);
    end
    conv1_biases_matrix = zeros(28,18,out_channel1);
    for i = 1:out_channel1
        conv1_biases_matrix(:,:,i) = conv1_biases(i);
    end


    conv1_preactivation = conv1 + conv1_biases_matrix;
    conv1_activated = relu(conv1_preactivation);
%     subplot(221)
%     imshow(conv1_activated(:,:,show_num)/255);
%     title('conv1_activated');

    %% pool1
    pool1=zeros(14,9,out_channel1);
    for i = 1:out_channel1
        pool1(:,:,i) = max_pooling1(conv1_activated(:,:,i));
    end
%     subplot(222)
%     pool1
%     imshow(pool1(:,:,show_num)/255);
%     title('pool1');
    %% conv2
    summary = zeros(14,9);
    conv2 = zeros(14,9,out_channel2);
    for out_channels=1:out_channel2
        for in_channels=1:out_channel1
            summary = summary +  conv2d_stride_1x1(pool1(:,:,in_channels),squeeze(conv2_weights(out_channels,in_channels,:,:))');
        end
        conv2(:,:,out_channels) = summary;
        summary=zeros(14,9);
    end
    conv2_biases_matrix = zeros(14,9,out_channel2);
    for i = 1:out_channel2
        conv2_biases_matrix(:,:,i) = conv2_biases(i);
    end
    conv2_preactivation = conv2 + conv2_biases_matrix;
    conv2_activated = relu(conv2_preactivation);
%     subplot(223)
%     imshow(conv2_activated(:,:,show_num)/255);
%     title('conv2_activated');
    %% pool2 
    pool2 = zeros(14,9,out_channel2);
    for i = 1:out_channel2
        pool2(:,:,i) = max_pooling2(conv2_activated(:,:,i));
    end

%     subplot(224)
%     imshow(pool2(:,:,show_num)/255);
%     title('pool2');
    %% local3
    pool2_reshape = [];
    for w = 1:14
        for h = 1:9
            pool2_reshape = [pool2_reshape;squeeze(pool2(w,h,:))];
        end
    end
    pool2_reshape = pool2_reshape';
    local3 = relu(pool2_reshape*local3_weights+local3_biases);

%     figure
%     imshow(local3);
%     title('local3');
    %% local4
%     local4 = relu(local3*local4_weights+local4_biases);
%     figure
%     imshow(local4);
%     title('local4');

    %% softmax layer
    softmax = local3*softmax_weights+softmax_biases;  % 到这一步结果就已经出来了
    [~,out(batch)] = max(sigmoid(softmax));
end
% closematlabpool;
end

    