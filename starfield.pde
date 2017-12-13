public class Starfield {
  private Star stars[];
  private int count;
  private PVector vel;
  
  public Starfield( int count ) {
    this.count = count;
    stars = new Star[count];
    for ( int i =0; i < count; i++) {
      stars[i] = new Star( random( width ), random( height ), random( 5,10 ));
    }
  }
  
  public void draw() {
    strokeWeight( 2 );
    for ( int i =0; i < count; i++) {
      stroke( stars[i].z * 25 );
      point( stars[i].x, stars[i].y );
    
      stars[i].x -= stars[i].z;
      if (stars[i].x < 0) { 
        stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
      }
    }
  }
}

class Star {
  float x, y, z;
  Star( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}