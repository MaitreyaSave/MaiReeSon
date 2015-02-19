function pen
global toggle
global fig
global h_axes
fig = findobj('tag','PEN');
if (isempty(fig))
    toggle = 0;

    fig = figure;
    
    plot([100,50],[500,500],'r','linewidth',6);
    hold on;
    plot([100,50],[450,450],'k','linewidth',5);
    hold on;
    plot([100,50],[360,360],'--k','linewidth',2);
    hold on;
    plot([100,50],[330,330],'r','linewidth',3);
    hold off;
    axis off;
    set(fig,'numbertitle','off');              
    set(fig,'name','PEN');    
    set(fig,'MenuBar','none');                  
    set(fig,'doublebuffer','on');               
    set(fig,'tag','PEN');                       
    set(fig,'Color',[1 1 1]);
    set(fig,'WindowButtonMotionFcn',@moviment);
    set(fig,'WindowButtonDownFcn',@moviment_down);
    set(fig,'WindowButtonUpFcn',@moviment_up);
    set(fig,'position',[50 400 1300 300]);
    
    h_axes = axes('position', [0 0 1 1]);
    set(h_axes,'Tag','AXES');
    
    axis(h_axes,[0 1 0 1]);
    axis(h_axes,'off');
    hold(h_axes,'on');
    
    
    

   
    
    clearbtn = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
        'Position', [20 20 150 50],...
        'FontSize',20,...
        'Callback', @clearplot);  
	capturebtn = uicontrol('Style', 'pushbutton', 'String', 'Capture',...
        'Position', [1130 20 150 50],...
        'FontSize',20,...
        'Callback',@cap); 
else
    figure(fig);
end
% #########################################################################

function moviment_down(hco,eventStruct)
global toggle x_pen y_pen

% toggle
toggle = 1;

h_axes = findobj('Tag','AXES');
p = get(h_axes,'CurrentPoint');
x = p(1,1);
y = p(1,2);

x_pen = [x_pen x];
y_pen = [y_pen y];

% #########################################################################

function moviment_up(hco,eventStruct)

global toggle x_pen y_pen

% toggle
toggle = 0;

h_axes = findobj('Tag','AXES');

delete(findobj('Tag','TRAJECTORIA2'));

x_i = min(x_pen);
x_f = max(x_pen);
x_d = max([1 (x_f - x_i)]);
y_i = min(y_pen);
y_f = max(y_pen);
y_d = max([1 (y_f - y_i)]);
% #########################################################################

function moviment(hco,eventStruct)
global toggle x_pen y_pen
global z
h_axes = findobj('Tag','AXES');

    
p = get(h_axes,'CurrentPoint');
x = p(1,1);
y = p(1,2);

if toggle
    
    if ((y < 0) || (y > 1) || (x < 0) || (x > 1))
        return;
    end
    
    if ((x ~= x_pen(end)) || (y ~= y_pen(end)))
        x_pen = [x_pen x];
        y_pen = [y_pen y];
        z=plot(h_axes,[x_pen(end-1) x],[y_pen(end-1) y],'k','linewidth',3,'Tag','TRAJECTORIA');
        
    end
end

function cap (hObject,eventdata)    
global fig
    screencapture(gcf,[150,77,1070,228],'C:\Users\Maitreya\project\image.png');  
    mH=msgbox('Captured');   
    uiwait(mH);
    close (fig);            
     
function clearplot (hObject,eventdata) 
global h_axes
cla(h_axes);
      



