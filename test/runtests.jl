using Collection
using Test


function BoxCalculation(Vertices)
								  #minimum ritorna il più piccolo della collezione
	Minx=minimum(Vertices[1,:])   # i : rappresentano tutte le colonne/righe in base a dove è posizionato.
	Maxx=maximum(Vertices[1,:])   # Vertices[1,:] indica tutti gli elementi della riga 1
	Miny=minimum(Vertices[2,:])
	Maxy=maximum(Vertices[2,:])
	dx=Maxx-Minx
	dy=Maxy-Miny
	Box=dx*dy
	if size(Vertices,1)==3
		Minz=minimum(Vertices[3,:])
		Maxz=maximum(Vertices[3,:])
		dz=Maxz-Minz
		Box=Box*dz
	end
	return Box
end

@testset "circle" begin
	@test BoxCalculation(Collection.circle()()[1])==4
	@test BoxCalculation(Collection.circle(1, 2*pi)()[1])==4 # è come di default
	@test BoxCalculation(Collection.circle(2., 2*pi)()[1])==16
	@test BoxCalculation(Collection.circle(3, 2*pi)()[1])==36
	@test BoxCalculation(Collection.circle(5, pi/2)()[1])==25 #aggiunto
	@test BoxCalculation(Collection.circle(7, 2*pi)()[1])==196

	@test length(Collection.circle(3,2*pi)([60])[2])==60
	@test size(Collection.circle(3,2*pi)([60])[1])==(2,60)   #aggiunta in modo corretto
end

@testset "helix" begin
	@test BoxCalculation(Collection.helix()()[1])==8
	@test BoxCalculation(Collection.helix(2, 2, 2)()[1])==64
	@test BoxCalculation(Collection.helix(1, 2, 5)()[1])==40
	@test BoxCalculation(Collection.helix(1, 1, 3)()[1])==12
	@test BoxCalculation(Collection.helix(1, 2, 3)()[1])==24 #aggiunta
	@test size(Collection.helix(5, 7, 9)()[1],2)==325
	@test length(Collection.helix(5, 7, 9)()[2])==324
end

@testset "disk" begin
	@test BoxCalculation(Collection.disk(1., 2*pi)([36, 1])[1])==4
	@test BoxCalculation(Collection.disk(2., 2*pi)()[1])==16
	@test BoxCalculation(Collection.disk(2., pi)()[1])==8
	@test BoxCalculation(Collection.disk(2., pi/2)()[1])==4

	@test size(Collection.disk(10, pi/7)()[1],2)==75
	@test length(Collection.disk(10, pi/7)()[2])==108
end

@testset "helicoid" begin
	@test BoxCalculation(Collection.helicoid()()[1])==8
	@test BoxCalculation(Collection.helicoid(2,1,2,2)()[1])==64
	@test BoxCalculation(Collection.helicoid(1,.5,2,5)()[1])==40
	@test BoxCalculation(Collection.helicoid(1,.3,1,3)()[1])==12
	@test BoxCalculation(Collection.helicoid(1,.3,0,2)()[1])==0    #aggiunta

	@test size(Collection.helicoid(1.3,.7,1,3)()[1],2)==327
	@test length(Collection.helicoid(1.3,.7,1,3)()[2])==432
end

@testset "ring" begin
	@test BoxCalculation(Collection.ring(1.,3.,2*pi)()[1])==36
	@test BoxCalculation(Collection.ring(1.,2,pi)()[1])==8
	@test BoxCalculation(Collection.ring(1.,5,pi/2)()[1])==25

	@test size(Collection.ring(1,5,pi/2)()[1],2)==74
	@test length(Collection.ring(5,10,pi/6)()[2])==72
end

@testset "cylinder" begin
	@test BoxCalculation(Collection.cylinder(1,5,2*pi)()[1])==20
	@test BoxCalculation(Collection.cylinder(2,2,pi)()[1])==16
	@test BoxCalculation(Collection.cylinder(1,4,pi)()[1])==8

	@test size(Collection.cylinder(3.4,20,pi/7)()[1],2)==74 #aggiunta
	@test length(Collection.cylinder(3.4,20,pi/7)()[2])==72
end

@testset "sphere" begin
	@test BoxCalculation(Collection.sphere(2,pi,2*pi)()[1])==64
	@test BoxCalculation(Collection.sphere(6,pi,pi)()[1])==864
	@test BoxCalculation(Collection.sphere(4,pi,2*pi)()[1])==8^3
	@test size(Collection.sphere(2.5,pi/3,pi/5)()[1],2)==703
	@test length(Collection.sphere(2.5,pi/3,pi/5)()[2])==1296
end

@testset "toroidal" begin
	@test BoxCalculation(Collection.toroidal(1,3,2*pi,2*pi)()[1])==128
	@test BoxCalculation(Collection.toroidal(2,3,2*pi,2*pi)()[1])==400

	@test size(Collection.toroidal(1.3,4.6,pi/4,pi/7)()[1],2)==925
	@test length(Collection.toroidal(1.3,4.6,pi/4,pi/7)()[2])==1728
end

@testset "crown" begin
	@test BoxCalculation(Collection.crown(1., 3., 2*pi)()[1])==128
	@test BoxCalculation(Collection.crown(2., 3., 2*pi)()[1])==400

	@test size(Collection.crown(1.5, 5.6, pi/8)()[1],2)==481
	@test length(Collection.crown(1.5, 5.6, pi/8)()[2])==864
end

@testset "ball" begin
	@test BoxCalculation(Collection.ball(1, pi, 2*pi)()[1])==8
	@test BoxCalculation(Collection.ball(6, pi, pi)()[1])==864
	@test BoxCalculation(Collection.ball(3, pi, 2*pi)()[1])==6^3
	@test size(Collection.ball(2.6, pi/5, pi/9)()[1],2)==2813
	@test length(Collection.ball(2.6, pi/5, pi/9)()[2])==2592
end

@testset "rod" begin
	@test BoxCalculation(Collection.rod(1,5,2*pi)()[1])==20
	@test BoxCalculation(Collection.rod(2,2,pi)()[1])==16
	@test BoxCalculation(Collection.rod(1,4,pi)()[1])==8

	@test size(Collection.rod(3.7,8.9,pi/9)()[1],2)==74
	@test length(Collection.rod(3.7,8.9,pi/9)()[2])==1
end

@testset "hollowCyl" begin
	@test BoxCalculation(Collection.hollowCyl(0,1.,5,2*pi)()[1])==20
	@test BoxCalculation(Collection.hollowCyl(1,2.,4,pi)()[1])==32
	@test BoxCalculation(Collection.hollowCyl(1,4,3,pi/2)()[1])==48

	@test size(Collection.hollowCyl(3,4.,7.8,pi/5)()[1],2)==148
	@test length(Collection.hollowCyl(3,4.,7.8,pi/5)()[2])==36
end

@testset "hollowBall" begin
	@test BoxCalculation(Collection.hollowBall(1,2,pi,2*pi)([36,36,1])[1]) ==64
	@test BoxCalculation(Collection.hollowBall(1,6,pi,pi)([36,36,1])[1])== 864
	@test BoxCalculation(Collection.hollowBall(2,4,pi,2*pi)([36,36,1])[1])==8^3

	@test size(Collection.hollowBall(1.5,6.7,pi/3,2*pi/3)()[1],2)==3700
	@test length(Collection.hollowBall(1.5,6.7,pi/3,2*pi/3)()[2])==2592
end

@testset "torus" begin
	@test BoxCalculation(Collection.torus(1.,2.,.5,2*pi,2*pi)()[1])==147
	@test BoxCalculation(Collection.torus(2,3,.5,2*pi,2*pi)()[1])==605.0

	@test size(Collection.torus(5.2,7,.5,pi/3,pi/4)()[1],2)==4625
	@test length(Collection.torus(5.2,7,.5,pi/3,pi/4)()[2])==3456
end
