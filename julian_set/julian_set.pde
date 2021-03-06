double[] c = {-.9000000001 , .000000005};
// add cool coordenates
//-1.4000000001 , .000000005
//-1.9000000001 , .000000005
double b_norm = 2;
double x,y,mid_x,mid_y;

int max_i = 500;
int pixel = color(0,0,0);
boolean start = true;
int d_count = 4;
double zoom = 1;

public int iteration(double[] cmplx)
{
  int out = color(0,0,0);
  int cont=0;
  double c_norm = norm(cmplx);
  //println(c_norm);
  while (c_norm < b_norm)
  {
    if(cont > max_i)
      break;
    else
    {
      cmplx = square(cmplx);
      cmplx[0] += c[0];
      cmplx[1] += c[1];
      c_norm = norm(cmplx);
    }
    cont++;
  }
  if (cont < 175)
    cont*=10;
  if (cont >= max_i)
    out = color (0,0,0);
  else
    out = color ((500 - cont),(175 - cont/2),(cont*2));// cool color
  //out = color ((cont/2)%255,(cont)%255,(2*cont));
  return out;
}
//good
public double norm(double[] cmplx)
{
  return Math.sqrt(cmplx[0]*cmplx[0] + cmplx[1]*cmplx[1]);
}

public double[] square(double[] cmplx) // z = z^2 + c
{
  double[] result = new double[2]; 
  result[0] = cmplx[0]*cmplx[0] - cmplx[1]*cmplx[1];
  result[1] = 2*cmplx[0]*cmplx[1];
  return result;
}
public void fractal(int deep)
{
  double[] cmplx = new double[2];
  for (int i=0;i<height;i++) // y
  {
     for(int j=0;j<width;j++)
     {
       cmplx[0] = ((double)(j - mid_x)/ (double)(100))/zoom;
       cmplx[1] = ((double)(i - mid_y)/ (double)(100))/zoom;
       pixel = iteration(cmplx);
       set(j,i,pixel);
     }
  }
}
public void setup()
{
  size(400,400);
  mid_x = width/2; // x =0
  mid_y = height/2; // y = 0
}
public void draw()
{
  if (start)
  {
    start = !start;
    fractal(d_count);
  }
}
public void keyPressed()
{
  //saveFrame();
  if(keyCode == (char)32)
  {
    zoom++;
    fractal(d_count);
  } else if(keyCode == RIGHT)
  {
    mid_x-=10;
    fractal(d_count);
  }
    else if(keyCode == LEFT)
  {
    mid_x+=10;
    fractal(d_count);
  }
  else if(keyCode == UP)
  {
    mid_y+=10;
    fractal(d_count);
  }
    else if(keyCode == DOWN)
  {
    mid_y-=10;
    fractal(d_count);
  }
  else if (keyCode == ',')
  {
    c[0] -= 0.001f;
    fractal(d_count);
  } else if (keyCode == '.')
  {
    c[0] += 0.001f;
    fractal(d_count);
  }
  //else if(keyCode == 'f')
     
  
}