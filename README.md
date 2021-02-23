CONTENIDO:
1.	Modelo de luz Wrap y Phong que incluya un color para el Phong.
2.	Soporte para una textura principal y un mapa de normales, siendo capaz de controlar su intensidad.
3.	Luz de Horizonte (Rim).
4.	Un color principal (Albedo) para dar color a toda la iluminación.
5.	Un efecto banded para modificar el modelo de forma procedural.
Utilizando el programa Unity se creó un Shader utilizando HLSL, este modelo está basado en Lambert y se creó para un modelo de bajo poligonaje en 3D.
1.	Phong y Wrap
Se empezó creando el efecto Phong dándole un color personalizado, este lo podríamos resumir en una concentración de luz en un punto en concreto, creando una especie de brillo o reflejo de luz generando sombra en el resto del modelo, para su creación se utilizaron funciones como reflect, viewdir, specularity y gloss, cada una cumpliendo funciones distintas y haciendo operaciones para lograr el efecto deseado. 
2.	Textura y Mapa de normales
Para la textura del objeto se utilizó una referente al modelo 3D, teniendo esta textura principal se consiguió el mapa de normales acorde a este. Para controlar la intensidad del efecto de profundidad en la textura se marcan ambas como 2D y se le asigna un rango. 
3.	Luz de Horizonte (Rim)
Al shader se le agregó luz de horizonte, mejor conocida como Rim, que consiste en una especie de halo alrededor del modelo u objeto generando luz en este, para lograrlo se invierte el brillo y se controla el color mediante saturación.


4.	Color Principal (Albedo) 
El color principal de iluminación conocido como albedo es modificable y consiste en 4 vectores. 
5.	Banded Effect
Finalmente tenemos el efecto banded el cual consiste en un Ramp en el cual nuestro objeto tiene una iluminación dividida en varios anillos con diferentes tonos cada uno hasta llegar al color negro, creando así la sombra con este efecto. Esta funciona con 256 steps para poder controlar el efecto.
