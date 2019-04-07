%Created by Stephen Johnston
%For ECE102
%2/16/2019
%LabJack testcode
function output = button_detection()
clear all
ljud_LoadDriver
ljud_Constants 
% Open the first found LabJack U3
[Error ljHandle] = ljud_OpenLabJack(LJ_dtU3,LJ_ctUSB,'1',1);
Error_Message(Error)
Error = ljud_ePut(ljHandle, LJ_ioPIN_CONFIGURATION_RESET, 0, 0, 0);

 
[Error  rValue] = ljud_eGet (ljHandle, LJ_ioPUT_ANALOG_ENABLE_BIT, 1, 1, 0);
Error_Message(Error)

buttonreadings = 0;
Error = ljud_ePut (ljHandle, LJ_ioPUT_DIGITAL_PORT,0,1, 1);
Error_Message(Error);
i = 1;
h = 1;
k = 1;
l = 1;
output = [];
%numbers = [2 1 1 3 2;5 33 4 6 0;9 9 9 9 9;8 0 7 0 0];
%%%%At higher frequencies this image changes. I'm not sure why. this works
%%%%at 60hz and below
%numbers = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15; 16 17 18 19 20]
%%%%The above vector is what I use to plot out the image
numbers = [0 1 3 5 0; 33 4 6 0 0; 0 0 9 8 0; 0 7 0 2 0];
%%%%This works at above 60hz. I tested it at 600hz and 6khz. It appears
%%%%that this is the legitimate mapping. The previous one must have been
%%%%reliant on some weird behavior of the counters at low frequencies
while   i <= 32
pause(.0005);
 [Error buttonreadings] = ljud_eGet(ljHandle, LJ_ioGET_AIN, 1, 0, 0);
Error_Message(Error);
Error = ljud_eGet(ljHandle, LJ_ioPUT_DIGITAL_PORT,0,1, 1);
Error_Message(Error);
pause(.0005)
Error = ljud_eGet(ljHandle, LJ_ioPUT_DIGITAL_PORT,0,0, 1);
Error_Message(Error);


    if i > 32
    i = 1;
    end
    if h >4
    h = 1;
    k = k + 1;
    end
    if k >4
    k = 1;
    end      
    if buttonreadings > 2.0

    output = numbers(k,h);
 
    end
    h = h + 1;
    i = i + 1;
end
end






