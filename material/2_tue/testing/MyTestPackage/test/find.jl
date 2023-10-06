
@testset "unit tests" begin
    @testset "find_max" begin
        @test find_max([1,2,3]) == 3
        @test find_max([0,0,0]) == 0
        
        @test_throws AssertionError find_max([NaN,3,2])
    end

    @testset "find_mean" begin
        @test find_mean([1,2,3]) == 2
        @test find_mean([1,3,6]) ≈ 3.333 atol=1e-3
      
    end
end

@testset "integration test" begin
    
    data1 = [43, 32, 167, 18, 1, 209]
    data2 = [3, 13, 33, 23, 498]

    # Expected result
    expected_mean_of_max = 353.5

    maximum1 = find_max(data1)
    maximum2 = find_max(data2)

    # Actual result
    actual_mean_of_max = find_mean([maximum1, maximum2])
    
    # Test
    @test actual_mean_of_max == expected_mean_of_max
    
end
