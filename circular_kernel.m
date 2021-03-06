function C=circular_kernel(r1,r2,varargin);

% Developer: Gregorio Marchesini 
% Date: 1 March 2021

%  Description
%  –––––––––––
%
%
% This function creates a matrix with an anular section of pixels.
%
%
%  INPUTS 
%  –––––––
% 
%  Variable           Description                   Data Type
%  ––––––––           –––––––––––                   –––––––––
%
%     r1              radious of the outer circle         scalar
%                     in pixels
%
%     r2              radious of the inner circle         scalar
%                     in pixels
%
%
% ------------------------------------------------------------------------
%
%  OUTPUTS
%  –––––––
% 
%  Variable           Description                   Data Type
%  ––––––––           –––––––––––                   –––––––––
%
%   M                 matrix with radious           array  (rxr)
%                     containing a circular 
%                     kernel
%
% ------------------------------------------------------------------------
%
%  Options
%  –––––––
%
%   Name              Description                   Data Type
%  ––––––––           –––––––––––                   –––––––––
%  
%  'rim'              define the value to           scalar
%                     be given at the rim 
%                     of the anulus%%
%
%  'stuff'            define the value to           scalar
%                     be given at the center 
%                     of the anulus
% ------------------------------------------------------------------------
%  NOTE: r must be integer or a .5 number (like 2.5). 
%

%% Parse the function

p=inputParser;
validationFcn1 = @(x) isnumeric(x) && isscalar(x) && (x > 0) && (abs((floor(x)-x)) == 0.5 | abs(floor(x)-x) == 0)  ; 
validationFcn2 = @(x) isnumeric(x) && isscalar(x) && (x >= 0) && x<r1  && (abs((floor(x)-x)) == 0.5 | abs(floor(x)-x) == 0);
addRequired(p,'r1',validationFcn1);
addRequired(p,'r2',validationFcn2);
addOptional(p,'stuff',0);
addOptional(p,'rim',1);
parse(p,r1,r2,varargin{:});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function

% case of 0.5 radious
if floor(r1) ~= r1
    C=zeros(2*r1);
    [X,Y]=meshgrid(1:2*r1);     % initialize the matrix
    % center of the matrix;
    x_center=floor(r1)+1;
    y_center=floor(r1)+1;

% case of even number radious
else
    C=zeros(2*r1+1);
    [X,Y]=meshgrid(1:2*r1+1);   % initialize the matrix (+1 for central pixel in case
                             %                         the radious is integes)
    % center of the matrix;
    x_center=r1+1;
    y_center=r1+1;
end


X=X-x_center;
Y=Y-y_center;
mod=(X.^2+Y.^2);
if p.Results.rim ~= 0
   C(mod<=r1^2 & mod>=r2^2)=p.Results.rim;
else
    C(mod<=r1^2 & mod>=r2^2)=1;
end
    

if p.Results.stuff ~= 0
  C(mod<r2^2)=p.Results.stuff;
end




end
% [row,col]=size(M);
% 
% for i=1:row
%     for j=1:col
%         if ((i-x_center)^2+(j-y_center)^2) <= r1^2 && ((i-x_center)^2+(j-y_center)^2) >= r2^2
%             M(i,j)=p.Results.rim;
%         elseif ((i-x_center)^2+(j-y_center)^2) < r2^2 && p.Results.stuff ~= 0
%             M(i,j)=p.Results.stuff;
%         end
%     end
% end


    
                
