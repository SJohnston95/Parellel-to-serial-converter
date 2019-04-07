%Created by Stephen Johnston
%For ECE102
%2/16/2019
%Remote code
function output = remote_code()
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
numbers = [2 1 1 3 0;5 10 4 6 0;9 9 9 9 9;8 0 7 0 0];
output = [];
while   i <= 32
pause(.01);
[Error buttonreadings] = ljud_eGet(ljHandle, LJ_ioGET_AIN, 1, 0, 0);
Error_Message(Error);
Error = ljud_eGet(ljHandle, LJ_ioPUT_DIGITAL_PORT,0,1, 1);
Error_Message(Error);
pause(.01)
Error = ljud_eGet(ljHandle, LJ_ioPUT_DIGITAL_PORT,0,0, 1);
Error_Message(Error);
    if buttonreadings > 2.0
    pause(1)
    output(l) = numbers(k,h);
    k;
    h;
    l = l + 1;
    end
    
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
    h = h + 1;
    i = i + 1;
end
end














