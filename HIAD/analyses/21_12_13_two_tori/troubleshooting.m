function [] = troubleshooting(FEM)

    not_matched  = 0;
    
    for i = 1:size(FEM.MODEL.nodes,1)
        idx = FEM.MODEL.connect(FEM.MODEL.connect(:,1:2) == i);
        if isempty(idx)
            not_matched = not_matched + 1;
        end
        idx = [];

    end
    
end