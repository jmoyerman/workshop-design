// Workshop Design Experiments
// 8' x 8' wood shop with existing utility sink

include <dimensions.scad>

echo("Material", "Part", "Width", "Height", "Z");

studs();
sink();
existingWorkbench();
frenchCleat();
dustCollection();
//tableSaw();
walls();

module tableSaw() {
    color("blue") 
    translate([20,-140,0])
    cube([46,31,38]);
}
module dustCollection() {
    // TODO add cleats
    // TODO bucket support
    // TODO side supports
    // TODO measurements
    // TODO actual vacuum
     vacHeight = 20.5; //with legs 23 without legs 20.5
     vacRadius = 13.5/2; // handles: 15/2
     vacBucketHeight = 12.5; // with legs: 15, without 12.5
     vacSquareWidth = 5; // 5x7
     vacSquareDepth = 7;
     vacHoseHeight = 10.5; // 13/ 10.5 to floor bottom of 2.5" hose 
     vacHoseRad = 1.25;
    color("blue") {
    bucketRadius = 6; // 6.25 at ridge
    bucketHeight = 14.5;
    
    deputyRadTop = 6.5/2; // TODO
    deputyRadBottom = 3.5/2; // TODO
    deputyHeight = 11; // TODO
    deputyHoseTop = 2.5;
    deputyPipeRad = 1.25; // TODO
    
    $fa = .5;
    $fs = .5;
    
    translate([backWall-bucketRadius-2*vacRadius-4,-bucketRadius-twoBy-2*plywood,60])
    rotate([0,0,-90]) {
        // Back Piece
        translate([-bucketRadius-plywood,-bucketRadius-1,-plywood])
        plywood(plywood, bucketRadius*2+2, bucketHeight+deputyHeight+2);
        // Bottom Piece
        translate([-bucketRadius,-bucketRadius-1,-plywood])
        plywood(bucketRadius*2+2,bucketRadius*2+2,plywood);
        // TODO side Left
        // TODO side right
        // TODO vaccuum bottom
        // TODO vaccuum back
//         translate([-bucketRadius, 0, vacHeight])
 //       plywood(plywood, vacRadius*2+2, vacHeight);
            
        
        // Vaccuum
        translate([vacRadius-bucketRadius, deputyRadTop + vacRadius+2, bucketHeight+deputyHeight+2*deputyHoseTop-vacHoseHeight]) rotate([0,0,-90]) {
        cylinder(vacBucketHeight, vacRadius, vacRadius);
        translate([-vacSquareWidth/2,-vacSquareDepth/2,vacBucketHeight]) cube([vacSquareWidth, vacSquareDepth, vacHeight - vacBucketHeight]);
        translate([bucketRadius,0,10.5]) rotate([0,90,0]) cylinder(deputyHoseTop, deputyPipeRad, deputyPipeRad);
        }
        // temp move
        // Bucket
        cylinder(bucketHeight,bucketRadius,bucketRadius);
        
        // Deputy
        translate([0,0,bucketHeight]) {
            cylinder(deputyHeight+3,deputyPipeRad,deputyPipeRad);
            cylinder(deputyHeight,deputyRadBottom,deputyRadTop);
            translate([3,2,deputyHeight-2])
            rotate([0,90,0])
            cylinder(4,deputyPipeRad,deputyPipeRad);
        }
   }
  
    }
    
}

module frenchCleat() {
    initialCleatHeight = 40;
    cleatSpacing = 6;
    
    // Left wall
    color("red") {
        translate([0,0,initialCleatHeight]) {
            rotate([0,0,270]) {
                translate([(twoBy), 0, 0]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 1*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 2*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 3*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 4*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 5*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 6*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);
                translate([(twoBy),0, 7*(cleatHeight + cleatSpacing)]) cleat(leftWall-(twoBy), cleatHeight, cleatThickness);

            }
        }
    }
    
    // Back wall
    translate([0,-1*twoBy,existingHeight])
    plywood(backWall, plywood, wallHeight-existingHeight);
    color("red") {
        translate([backWall, -1*(twoBy),initialCleatHeight]) {
            rotate([0,0,180]) {
                cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 1*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 2*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 3*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 4*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 5*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 6*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
                translate([0,0, 7*(cleatHeight + cleatSpacing)]) cleat(backWall-plywood, cleatHeight, cleatThickness);
            }
        }
    }
}

module cleat(w,h,t){
    // Lifted from: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
    cleatFaces=[
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3]]; // left
    
    cleatPoints=[
        // Bottom Four
        [0,0,0], 
        [w,0,0], 
        [w,t,0],
        [0,t,0],
        [0,0,h-t],
        [w,0,h-t],
        [w,t,h],
        [0,t,h]];
    polyhedron(cleatPoints, cleatFaces);
    echo("Plywood", "cleat", w, h);
}

module plywood(l,w,h) {
    cube([l,w,h]);
    echo("Plywood", "cut", l,w,h);
}

module existingWorkbench() {
    color("khaki") {

        translate([0,0,existingHeight]) {
            //left
            translate([0,-68,0])
            cube([25.5,68,.75]);
            //back
            translate([0,-25.5,0])
            cube([93,25.5,.75]);
            //right
            translate([65,-96,0])
            cube([28,96,.75]);
        }

        translate([0,0,8]) {
            //left
            translate([0,-68,0])
            cube([25.5,68,.75]);
            //back
            translate([0,-25.5,0])
            cube([93,25.5,.75]);
            //right
            translate([65,-96,0])
            cube([28,96,.75]);
        }


        // Left legs
        translate([0,-3.5,0])
        cube([1.5,3.5,existingHeight]);
        translate([0,-68,0])
        cube([1.5,3.5,existingHeight]);
        // Second Row
        translate([24,0,0]) {
            translate([0,-3.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-25.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-68,0])
            cube([1.5,3.5,existingHeight]);
        }
        // Third Row
        translate([65,0,0]) {
            translate([0,-3.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-25.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-60.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-96,0])
            cube([1.5,3.5,existingHeight]);
        }
        // Fourth Row
        translate([backWall-1.5,0,0]) {
            translate([0,-3.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-25.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-60.5,0])
            cube([1.5,3.5,existingHeight]);
            translate([0,-96,0])
            cube([1.5,3.5,existingHeight]);
        }
    }
}


module walls() {

        // Walls
        // Block Walls
    color("DarkSlateGray",0.25) {
        //back wall
        cube([backWall,wallDepth,wallHeight]);
        // window wall
        difference() {
            translate([backWall,-rightWall,0]) cube([wallDepth,rightWall,wallHeight]);
            translate([backWall-1,-rightWall/2-16,60]) cube([wallDepth*2+1,32,32]);
        }
    }
        // Drywall Wall
        color("white", 0.25) {
        translate([-wallDepth,-leftWall,0]) cube([wallDepth,leftWall,wallHeight]);
    }

}

module sink() {
    color("Gainsboro") 
    translate([0,-96, 16]) {
        difference(){
            cube([25,28,20]);
            translate([1,1,1]) cube([23,26,20]);
        }
    }
    color("Gainsboro") 
    translate([0,-96,0]){
        translate([1,0,0]) cube([1,1,20]);
        translate([24,0,0]) cube([1,1,20]);
        translate([24,27,0]) cube([1,1,20]);
        translate([1,27,0]) cube([1,1,20]);
       
    }
}

module studs() {
    // TODO measure
    translate([0,-1.5,50]){
        translate([0,0,0])cube([3.5,1.5,40]);
        translate([32,0,0])cube([3.5,1.5,40]);
        translate([64,0,0])cube([3.5,1.5,40]);
        translate([89,0,0])cube([3.5,1.5,40]);


    }
}
