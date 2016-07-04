namespace mathChecker{
	class MathObject{
		public:
			virtual bool equals(MathObject &object)=0;
			virtual void random()=0;
	};
	template<typename T> class Set : MathObject{ };

	class Complex : public MathObject{ };
	class Real : public Complex{ };
	class Integer : public Real{ };

	template<typename T> class Tensor : MathObject{ };
	template<typename T> class Matrix : public Tensor<T>{ };
	template<typename T> class Vector : public Matrix<T>{ };

	template<typename D,typename C> class Function : MathObject{ };

	namespace Geometry{
		class Point{ };
		class Rect{ };
		class Plane{ };

		class Path{ };
		class Segment : public Path{ };
		class Polygon : public Path{ };

		class Arc{ };
		class Circle{ };
	}
}
