module ConwayCircles

using SimpleDrawing, SimpleDrawingObjects, Clines, Plots

export ConwayCircle

export _extension_points, _draw_triangle

"""
	extension_points(A::Complex, B::Complex, C::Complex)

Find the two points extended from `A` with length `|BC|`.
"""
function _extension_points(A::Complex, B::Complex, C::Complex)
	a = abs(B-C)  # length of extension_points

	# unit vector from A opposite B
	v = (B-A)
	v /= abs(v)
	z1 = A - a*v

	w = (C-A)
	w /= abs(w)
	z2 = A-a*w

    # debug 

    # draw_segment(A,z1)
    # draw_segment(A,z2)
    # draw_point(z1)
    # draw_point(z2)


	return z1, z2
end

function _draw_triangle(A::Complex, B::Complex, C::Complex)
    # draw the vertices and edgs of the given triangle
    for Z in [A,B,C]
        P = Point(Z)
        set_pointsize!(P,3)
        draw(P)
    end

    for ZZ in [ (A,B), (A,C), (B,C)]
        S = Segment(ZZ...)
        draw(S)
    end
end


function ConwayCircle(A::Complex, B::Complex, C::Complex)
    newdraw()

    _draw_triangle(A,B,C)

    trips = [ (A,B,C), (B,C,A), (C,A,B)]

    point_list = Complex[]

    # draw extensions from vertices 
    for t in trips 
        Z1, Z2 = _extension_points(t...)
        push!(point_list,Z1)
        for Z in [Z1,Z2]
            S = Segment(t[1], Z)
            set_linestyle!(S,:dot)
            draw(S) 
            P = Point(Z)
            draw(P)
        end
    end
    
    Z = Clines.Circle(point_list...)
    
    z = center(Z)
    r = radius(Z)

    ZZ = SimpleDrawingObjects.Circle(z,r)
    set_linestyle!(ZZ,:dash)
    draw(ZZ)


    finish()
end

end # module ConwayCircles
