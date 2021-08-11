using Test
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation

#HO DEFINITO ESTERNAMENTE I MIEI PARAMETRI DA INSERIRE IN SIMPLIFYCELLS E SUBITO DOPO INIZIERÒ A TESTARLA!
#I PARAMETRI DEFINITI NON SONO MOLTI PER ORA POICHÈ DEVO CAPIRE BENE COSA E COME TESTARLA .NEL NOTEBOOK INVECE SONO STATI DEFINITI MOLTI PIU PARAMETRI .
#POICHE QUI NON STO MISURANDO LE PRESTAZIONI , MA LA FUNZIONALITÀ

V=[1.0 2.1234567 3.0 4.0 5.0 6.0 7.0; 1.0 2.1234567 3.0 4.0 5.0 6.0 7.0]
CV=[1,2,7,3,1]
B=[[1,2,3,4],[1,2],1,1,1]

@testset "SimplifyCells Tests" begin
	simp = Lar.simplifyCells(V,CV)
	@testset "SimplifyCells General Tests " begin
		@test typeof(simp)==Tuple{Array{Float64,2},Array{Array{Int64,1},1}}
		@test length(simp)==2
		@test size(simp[1])==(2, 4)
	end
	@testset "SimplifyCells Specific Tests " begin
		@test Lar.simplifyCells(V,CV) == ([1.0 2.12346 7.0 3.0; 1.0 2.12346 7.0 3.0], [[1], [2], [3], [4], [1]])
		@test Lar.simplifyCells(V,B)  == ([1.0 2.12346 3.0 4.0; 1.0 2.12346 3.0 4.0], [[4, 2, 3, 1], [2, 1], [1], [1], [1]])
		@test Lar.simplifyCells(V,CV) != ([1.0 2.12346 7.0 3.0; 1.0 2.12346 7.0 3.0], [[1], [2], [7], [4], [1]])
	end
end



@testset "cuboid Tests" begin
	square=Lar.cuboid([1,1])    #quadrato quindi sono settate solamente 2 variabili per rendere il cubo in 2D
	cube=Lar.cuboid([1,1,1])    #cubo quindi sono settate 3 variabili cubo rappresentato quidi 3D
	@testset "cuboid Tests 2D" begin
		@test typeof(square)==Tuple{Array{Float64,2},Array{Array{Int64,1},1}}       #tipo del quadrato ci aspetteremo una tupla di 2 array di tipo float e int
		@test length(square)==2														#lunghezza del quadrato
		@test size(square[1])==(2, 4)
	end
	@testset "cuboid Tests 3D" begin
		@test typeof(cube)==Tuple{Array{Float64,2},Array{Array{Int64,1},1}}
		@test length(cube)==2
		@test size(cube[1])==(3, 8)
	end
end

#ragionamenti a seguire uguali a prima ma con applicazione di traslazioni , anche per 3D
@testset "2D" begin
	square = ([[0.; 0] [0; 1] [1; 0] [1; 1]], [[1, 2, 3,
			4]], [[1,2], [1,3], [2,4], [3,4]])
	@testset "apply Translation 2D" begin
		@test typeof(Lar.apply(Lar.t(-0.5,-0.5),square))==Tuple{Array{Float64,2},Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test Lar.apply(Lar.t(-0.5,-0.5),square)==([-0.5 -0.5 0.5 0.5; -0.5 0.5 -0.5 0.5], Array{Int64,1}[[1, 2, 3, 4]], Array{Int64,1}[[1, 2], [1, 3], [2, 4], [3, 4]])
	end
	@testset "apply Scaling 2D" begin
		@test typeof(Lar.apply(Lar.s(-0.5,-0.5),square))==Tuple{Array{Float64,2},Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test Lar.apply(Lar.s(-0.5,-0.5),square)==([0.0 0.0 -0.5 -0.5; 0.0 -0.5 0.0 -0.5], Array{Int64,1}[[1, 2, 3, 4]], Array{Int64,1}[[1, 2], [1, 3], [2, 4], [3, 4]])
	end
	@testset "apply Rotation 2D" begin
		@test typeof(Lar.apply(Lar.r(0),square))==Tuple{Array{Float64,2},Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test Lar.apply(Lar.r(0),square)==([0.0 0.0 1.0 1.0; 0.0 1.0 0.0 1.0], Array{Int64,1}[[1, 2, 3, 4]], Array{Int64,1}[[1, 2], [1, 3], [2, 4], [3, 4]])
	end
end


@testset "3D" begin
	cube=Lar.cuboid([1,1,1])
	@testset "apply Translation 3D" begin
		@test typeof(Lar.apply(Lar.t(-0.5,-0.5,-0.5),cube))==Tuple{Array{Float64,2},Array{Array{Int64,1},1}}
		@test Lar.apply(Lar.t(-0.5, -0.5, -0.5),cube) ==
		([-0.5 -0.5 -0.5 -0.5 0.5 0.5 0.5 0.5;
		-0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5; -0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5],
		Array{Int64,1}[[1, 2, 3, 4, 5, 6, 7, 8]])
	end
	@testset "apply Scaling 3D" begin
		@test typeof(Lar.apply(Lar.s(-0.5,-0.5,-0.5),cube))==
		Tuple{Array{Float64,2},Array{Array{Int64,1},1}}
		@test Lar.apply(Lar.s(-0.5, -0.5, -0.5),cube) ==
		([0.0 0.0 0.0 0.0 -0.5 -0.5 -0.5 -0.5;
		0.0 0.0 -0.5 -0.5 0.0 0.0 -0.5 -0.5; 0.0 -0.5 0.0 -0.5 0.0 -0.5 0.0 -0.5],
		Array{Int64,1}[[1, 2, 3, 4, 5, 6, 7, 8]])
	end
end
