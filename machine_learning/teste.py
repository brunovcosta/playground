import matplotlib.pyplot as plt
import numpy as np
from matplotlib import style
style.use('ggplot')

class SVM:
    def __init__(self,viz=True):
        self.viz=viz
        self.col = {1:'g',-1:'r'}
        if self.viz:
            self.fig = plt.figure()
            self.ax = self.fig.add_subplot(1,1,1)

    # Train
    def fit(self,data):
        self.data = data
        #{ ||w||: [w,b] }

        opt_dict = {}

        transforms = [
            [1,1],
            [-1,1],
            [-1,-1],
            [1,-1]
        ]

        components = []

        print 'Fill components'
        print 'self.data'
        print self.data
        for yi in self.data:
            print 'yi'
            print yi
            for point in self.data[yi]:
                print 'point'
                print point
                for component in point:
                    print 'component'
                    print component
                    components.append(component)

        self.max_component_value = max(components)
        self.min_component_value = min(components)

        print 'self.max_component_value'
        print self.max_component_value
        print 'self.min_component_value'
        print self.min_component_value
        components = None
        
        # support vectors yi(xi.w+b) = 1

        step_sizes = [
            self.max_component_value*0.1,
            self.max_component_value*0.01,
            # point of expense
            self.max_component_value*0.001
        ]

        # extremely expensive

        b_range_multiple = 5
        # 
        b_multiple = 5
        
        latest_optimim = self.max_component_value*10
        print 'latest_optimim'
        print latest_optimim

        for step in step_sizes:
            w = np.array([latest_optimim,latest_optimim])

            # we can do this because convex
            optimized = False
            while not optimized:
                for b in np.arange(-1*(self.max_component_value*b_range_multiple),
                        self.max_component_value*b_range_multiple,
                        step*b_multiple):

                    for transformation in transforms:
                        w_t = w*transformation
                        found_option = True
                        # weakest link in the SVM fundamentally
                        # SMO attempts to fix this a bit
                        # yi(xi.w+b)
                        for i in self.data:
                            for xi in self.data[i]:
                                yi=i
                                if not yi*(np.dot(w_t,xi)+b) >= 1:
                                    found_option = False

                        if found_option:
                            opt_dict[np.linalg.norm(w_t)] = [w_t,b]

                if w[0] < 0:
                    optimized = True
                    print('Optimized a step!')

                else:
                    w = w-step
            norms = sorted([n for n in opt_dict])

            opt_choice = opt_dict[norms[0]]
            self.w = opt_choice[0]
            self.b = opt_choice[1]

            latest_optimim = opt_choice[0][0]+step*2


    def predict(self,components):
        # sign(x.w+b)
        classification = np.sign(np.dot(no.array(components),self.w)+self.b)

        if classification != 0 and self.viz:
            self.ax.scatter(components[0],components[1],s=200,marker='*',c=self.col[classification])
        return classification

    def vizualize(self):
        [[self.ax.scatter(x[0],x[1],s=100,color=self.col[i]) for x in data_dict[i]] for i in data_dict]

        # hyperplane = x.w+b
        # v = x.w+b
        # psv = 1
        # nsv = -1
        # dec = 0

        def hyperplane(x,w,b,v):
            return (-w[0]*x-b+v) / w[1]

        datarange = (self.min_component_value*0.9,self.max_component_value*1.1)

        hyp_x_min = datarange[0]
        hyp_x_max = datarange[1]

        # (w.x+b) = 1
        # positive support vector hyperplane

        psv1 = hyperplane(hyp_x_min,self.w,self.b,1)
        psv2 = hyperplane(hyp_x_max,self.w,self.b,1)
        self.ax.plot([hyp_x_min,hyp_x_max],[psv1,psv2])

        # (w.x+b) = -1
        # positive support vector hyperplane

        nsv1 = hyperplane(hyp_x_min,self.w,self.b,-1)
        nsv2 = hyperplane(hyp_x_max,self.w,self.b,-1)
        self.ax.plot([hyp_x_min,hyp_x_max],[nsv1,nsv2])

        # (w.x+b) = 0
        # positive support vector hyperplane

        dv1 = hyperplane(hyp_x_min,self.w,self.b,0)
        dv2 = hyperplane(hyp_x_max,self.w,self.b,0)
        self.ax.plot([hyp_x_min,hyp_x_max],[dv1,dv2])

        plt.show()





data_dict = {
    -1: np.array([
        [1,7],
        [2,8],
        [3,8]
    ]),

    +1: np.array([
        [5,1],
        [6,-1],
        [7,3]
    ])
}

svm = SVM()
svm.fit(data=data_dict)
svm.vizualize()
