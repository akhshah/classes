%% Minimizer Function
function [x, iterations] = minimizer(x0, Q, b, epsilon)
x = x0;
iterations = 0;
for i=1:1e5
    grad = g(x(:,i), Q, b);
    alpha = step(x(:,i), Q, b, grad);
    
    x(:,i+1) = x(:,i) - alpha*grad;
    
    iterations = iterations + 1;
    
    % Stopping Criteria
    if i ~= 1
        if (norm(x(:,i) - x(:,i-1)) < epsilon)
            break;
        end
    end
end
end

%% Supporting Functions
function grad = g(x, Q, b)
grad = Q*x - b;
end

function alpha = step(x, Q, b, grad)
alpha = (-grad'*b + grad'*Q*x)/(grad'*Q*grad);
end