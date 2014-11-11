classdef Container < handle
  
  properties (Dependent)
    value
  end
  
  properties (SetAccess = 'private')
    cache = []
    fct = @() []
    args = {}
    deps = {}
  end
  
  methods        
    function self = Container(fct, varargin)
      self.fct = fct;
      self.args = varargin;      
      % store dependencies
      for arg = self.args
        if isa(arg{1}, 'Container')
          arg{1}.deps{end+1} = self;
        end
      end
    end
    
    function val = get.value(self)
      if isempty(self.cache)
        argvals = evalArgs(self);
        self.cache = self.fct(argvals{:});
      end
      val = self.cache;
    end
    
    function set.value(self, val)
      self.cache = val;
      % clear dependencies
      for dep = self.deps
        dep{1}.reset();
      end
    end
    
    function reset(self)
      self.value = []
    end
    
    function argvals = evalArgs(self)
      argvals = self.args;
      for i = 1:length(argvals)
        if isa(argvals{i}, 'Container')
          argvals{i} = argvals{i}.value;
        end
      end
    end
  end
end