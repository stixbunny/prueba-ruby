def read_alum(file_name)
 file = File.open(file_name, 'r')
 alum = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
 file.close
 alum
end

def promedios()
  $alumnos.each do |alumno|
    suma = alumno.inject(0) do |sum, nota|
      if nota == "A"
        sum
      elsif nota.to_i.to_s != nota
        print "#{nota}: "
        sum = 0
      else
        sum + nota.to_i
      end
    end
    promedio = suma.to_f / (alumno.count - 1)
    print "#{promedio}\n"
  end
end

def inasistencias()
  $alumnos.each do |alumno|
    suma = alumno.inject(0) do |sum, nota|
      if nota == "A"
        sum + 1
      elsif nota.to_i.to_s != nota
        print "#{nota}: "
        sum = 0
      else
        sum
      end
    end
    if suma == 0 or suma == 1
      puts "#{suma} inasistencia"
    else
      puts "#{suma} inasistencias"
    end
  end
end

def aprobado?(promedio, necesario = 5)
  return promedio >= necesario
end

def aprobados()
  puts "Aprobaron..."
  $alumnos.each do |alumno|
    nombre = ""
    suma = alumno.inject(0) do |sum, nota|
      if nota == "A"
        sum
      elsif nota.to_i.to_s != nota
        nombre = nota
        sum = 0
      else
        sum + nota.to_i
      end
    end
    promedio = suma.to_f / (alumno.count - 1)
    if aprobado?(promedio)
      puts "#{nombre}"
    end
  end
end

$alumnos = read_alum("alumnos.csv")
quit = false

while !quit
  print "Bienvenido al menú\n\t1) Ver el promedio de notas\n\t2) Ver inasistencias\n\t3) Ver alumnos aprobados\n\t4) Salir\n"
  opcion = gets.chomp.to_i
  case opcion
  when 1
    promedios()
  when 2
    inasistencias()
  when 3
    aprobados()
  when 4
    quit = true
  else
    puts "Opción inválida"
  end
end
