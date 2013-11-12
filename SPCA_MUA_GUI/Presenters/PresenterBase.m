classdef PresenterBase < handle
    %CONTROLLERBASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        model
        view
    end
    
    methods
        function obj = PresenterBase(model)
            obj.model = model;
            %obj.view = ViewBase(obj);
        end
    end
    
end

