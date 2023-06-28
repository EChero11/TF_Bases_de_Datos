//Alex
/*======================================================================================*/
// Mostrar las pólizas que el monto sea igual o mayor a 1000 y la prima sea la mitad o más del monto.
db.polizas.find({
  $and: [
    { monto: { $gte: 1000 } },
    { prima: { $gte: 500, $lte: 1000 } }
  ]
})


// Mostrar los historiales médicos de las personas que no tengan alergia a la penicilina y no esten estables.
db.historial_medico_asegurados.find({
  $and: [
     { resultado: { $ne: "Estable" } },
    { alergias: { $ne: "penicillina" } }
  ]
})
/*======================================================================================*/
//Eduardo
/*======================================================================================*/
// 1. Obtener el promedio de las primas de todas las pólizas:

db.polizas.aggregate([
  {
    $group: {
      _id: null,
      promedio_primas: { $avg: "$prima" }
    }
  }
])

// 2. Obtener los asegurados que tienen más de 40 años y están casados

db.asegurados.find({
  $expr: {
    $and: [
      { $gt: [ { $toInt: { $substr: ["$f_nacimiento", 0, 4] } }, { $subtract: [ { $year: new Date() }, 40 ] } ] },
      { $eq: [ "$estado_civil", "casado" ] }
    ]
  }
})
/*======================================================================================*/
//André
/*======================================================================================*/

/*======================================================================================*/
//Sebas
/*======================================================================================*/

/*======================================================================================*/
//Josué
/*======================================================================================*/
//Indicar la cantidad de polizas vendidas de un solo tipo por cada agente
db.polizas.aggregate([
  {
    $match: { descripcion: 'Póliza de vida' }
  },
  {
    $group: {
        _id: '$id_agente',
        quantity : {$count: {}}
    }
  }
]);

//Indicar la cantidad de polizas por cada tipo
db.polizas.aggregate([
  {
    $group: {
        _id: '$descripcion',
        quantity: {$count:{}}
    }
  }
]);
/*======================================================================================*/

/*======================================================================================*/
//Abraham
//Mostrar los datos de las personas que tengan apellido "Torres" y esté "Estable"
db.asegurados.find({
    $and: [
    {apellido: "Torres"},
    {resultado:{$ne: "Estable"}}
    ]
})

// Mostrar los datos de los asegurados que estén en trabajo "Asistente de Limpieza ó Vendedor Ambulante"
db.asegurados.find({
    $or: [
    {"trabajo.cargo":"Asistente de limpieza"},
    {"trabajo.cargo": "Vendedor ambulante" }
    ]
})
