use TF_MongoDB

db.dropDatabase(TF_MongoDB)

db.createCollection("asegurados", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["nombre", "apellido", "dni", "direccion", "telefono", "correo", "f_nacimiento", "estado_civil",
                "sexo", "historial_medico", "trabajo", "pago"],
            properties: {
                nombre: {
                    bsonType: "string",
                },
                apellido: {
                    bsonType: "string",
                },
                dni: {
                    bsonType: "string",
                },
                direccion: {
                    bsonType: "string",
                },
                telefono: {
                    bsonType: "string",
                },
                correo: {
                    bsonType: "string",
                },
                f_nacimiento: {
                    bsonType: "string",
                },
                estado_civil: {
                    bsonType: "string",
                },
                sexo: {
                    bsonType: "string",
                },
                historial_medico: {
                    bsonType: "objectId", // Referencia al _id de "historial_medico_asegurados"
                },
                trabajo: {
                    bsonType: "object",
                    required: ["f_ingreso", "cargo", "sueldo"],
                    properties: {
                        f_ingreso: {
                            bsonType: "string",
                        },
                        cargo: {
                            bsonType: "string",
                        },
                        sueldo: {
                            bsonType: "string",
                        },
                    }
                },
                pago: {
                    bsonType: "string", //Visa - Mastercard - American Express
                },
            }
        }
    }
})

//agregar requerimientos a la coleccion asegurados

db.runCommand({
    collMod: "asegurados",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["nombre", "apellido", "dni", "direccion", "telefono", "correo", "f_nacimiento", "estado_civil",
                "sexo", "historial_medico", "trabajo", "pago", "poliza"],
            properties: {
                nombre: {
                    bsonType: "string",
                },
                apellido: {
                    bsonType: "string",
                },
                dni: {
                    bsonType: "string",
                },
                direccion: {
                    bsonType: "string",
                },
                telefono: {
                    bsonType: "string",
                },
                correo: {
                    bsonType: "string",
                },
                f_nacimiento: {
                    bsonType: "string",
                },
                estado_civil: {
                    bsonType: "string",
                },
                sexo: {
                    bsonType: "string",
                },
                historial_medico: {
                    bsonType: "objectId", // Referencia al _id de "historial_medico_asegurados"
                },
                trabajo: {
                    bsonType: "object",
                    required: ["f_ingreso", "cargo", "sueldo"],
                    properties: {
                        f_ingreso: {
                            bsonType: "string",
                        },
                        cargo: {
                            bsonType: "string",
                        },
                        sueldo: {
                            bsonType: "string",
                        },
                    }
                },
                pago: {
                    bsonType: "string", //Visa - Mastercard - American Express
                },
                poliza: {
                    bsonType: "objectId", // Referencia al _id de "polizas"
                },
            }
        }
    }
})

// inserta datos en la colección asegurados

db.asegurados.insertOne({
    nombre: "Juan",
    apellido: "Perez",
    dni: "09643152",
    direccion: "Av. Los Olivos 123",
    telefono: "987654321",
    correo: "J.perz@gmail.com",
    f_nacimiento: "1990-01-01",
    estado_civil: "Casado",
    sexo: "Masculino",
    historial_medico: ObjectId("5f9b0b0b9b0b0b0b0b0b0b0b"),
    trabajo: {
        f_ingreso: "2010-01-01",
        cargo: "Ayudante de reparto",
        sueldo: "900",
    },
    pago: "Visa",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e70"),
})

db.asegurados.insertMany([
{
    nombre: "Maria",
    apellido: "Jimenez",
    dni: "14250986",
    direccion: "Av. Los Olivos 123",
    telefono: "999258165",
    correo: "mary_J@hotmail.com",
    f_nacimiento: "1990-10-04",
    estado_civil: "Casado",
    sexo: "Femenino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e5b"),
    trabajo: {
        f_ingreso: "2010-06-03",
        cargo: "Vendedor ambulante",
        sueldo: "800",
    },
    pago: "Mastercard",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e71"),
},
{
    nombre: "Pedro",
    apellido: "Gómez",
    dni: "543216789",
    direccion: "Plaza Principal 789",
    telefono: "9876543210",
    correo: "pedro@gmail.com",
    f_nacimiento: "1985-07-20",
    estado_civil: "soltero",
    sexo: "masculino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e5c"),
    trabajo: {
        f_ingreso: "2007-03-01",
        cargo: "Ayudante de construccion",
        sueldo: "1050"
    },
    pago: "Efectivo",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e72")
},
{
    nombre: "Ana",
    apellido: "González",
    dni: "987654321",
    direccion: "Calle Secundaria 789",
    telefono: "0123456789",
    correo: "ana@gmail.com",
    f_nacimiento: "1992-11-10",
    estado_civil: "soltero",
    sexo: "femenino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e5d"),
    trabajo: {
        f_ingreso: "2015-09-01",
        cargo: "Auxiliar de almacen",
        sueldo: "950"
    },
    pago: "Visa",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e73")
},
{
    nombre: "Carlos",
    apellido: "Rodríguez",
    dni: "543216789",
    direccion: "Avenida Central 789",
    telefono: "9012345678",
    correo: "carlos@gmail.com",
    f_nacimiento: "1980-12-05",
    estado_civil: "casado",
    sexo: "masculino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e5e"),
    trabajo: {
        f_ingreso: "2005-07-01",
        cargo: "Asistente de eventos",
        sueldo: "1000"
    },
    pago: "Mastercard",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e74")
},
{
    nombre: "Laura",
    apellido: "Hernández",
    dni: "123456789",
    direccion: "Calle Principal 456",
    telefono: "7890123456",
    correo: "laura@gmail.com",
    f_nacimiento: "1998-04-25",
    estado_civil: "soltero",
    sexo: "femenino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e5f"),
    trabajo: {
        f_ingreso: "2020-01-01",
        cargo: "Empleado de tienda",
        sueldo: "1100"
    },
    pago: "Visa",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e75")
},
{
    nombre: "Jorge",
    apellido: "Silva",
    dni: "543216789",
    direccion: "Plaza Principal 123",
    telefono: "6543210987",
    correo: "jorge@gmail.com",
    f_nacimiento: "1982-08-15",
    estado_civil: "casado",
    sexo: "masculino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e60"),
    trabajo: {
        f_ingreso: "2011-06-01",
        cargo: "Cuidador de mascotas",
        sueldo: "900"
    },
    pago: "Mastercard",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e76")
},
{
    nombre: "Sofía",
    apellido: "Martínez",
    dni: "987654321",
    direccion: "Avenida Central 123",
    telefono: "8765432109",
    correo: "sofia@gmail.com",
    f_nacimiento: "1993-09-20",
    estado_civil: "soltero",
    sexo: "femenino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e61"),
    trabajo: {
        f_ingreso: "2013-11-01",
        cargo: "Repartidor de volantes",
        sueldo: "800"
    },
    pago: "Efectivo",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e77")
},
{
    nombre: "Miguel",
    apellido: "Torres",
    dni: "543216789",
    direccion: "Calle Secundaria 456",
    telefono: "7654321098",
    correo: "miguel@gmail.com",
    f_nacimiento: "1987-02-10",
    estado_civil: "casado",
    sexo: "masculino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e62"),
    trabajo: {
        f_ingreso: "2008-09-01",
        cargo: "Ayudante de cocina",
        sueldo: "1200"
    },
    pago: "Visa",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e78")
},
{
    nombre: "Ana",
    apellido: "López",
    dni: "123456789",
    direccion: "Avenida Central 456",
    telefono: "6543210987",
    correo: "ana@gmail.com",
    f_nacimiento: "1991-12-05",
    estado_civil: "soltero",
    sexo: "femenino",
    historial_medico: ObjectId("60d3c9e81959d61f8d4e4e63"),
    trabajo: {
        f_ingreso: "2016-08-01",
        cargo: "Asistente de limpieza",
        sueldo: "1000"
    },
    pago: "Mastercard",
    poliza: ObjectId("60d3c9e81959d61f8d4e4e79")
}
])

db.asegurados.find()

//eliminar datos de asegurados

db.asegurados.deleteMany({})

//Historial Medico con los id de la colección de asegurados

db.createCollection("historial_medico_asegurados", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id_asegurado", "alergias", "enfermedades", "medicamentos", "resultado", "observaciones"],
            properties: {
                id_asegurado: {
                    bsonType: "objectId",
                    description: "ID del asegurado"
                },
                alergias: {
                    bsonType: "string",
                    description: "Alergias del asegurado"
                },
                enfermedades: {
                    bsonType: "string",
                    description: "Enfermedades del asegurado"
                },
                medicamentos: {
                    bsonType: "string",
                    description: "Medicamentos del asegurado"
                },
                resultado: {
                    bsonType: "string",
                    description: "Resultado del asegurado"
                },
                observaciones: {
                    bsonType: "string",
                    description: "Observaciones del asegurado"
                }
            }
        }
    }
})

db.historial_medico_asegurados.insertMany([
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5a"),
    alergias: "Polen",
    enfermedades: "Asma",
    medicamentos: "Ventolin",
    resultado: "Estable",
    observaciones: "Control regular"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5b"),
    alergias: "Penicilina",
    enfermedades: "Hipertensión",
    medicamentos: "Losartan",
    resultado: "Estable",
    observaciones: "Dieta baja en sodio"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5c"),
    alergias: "Ninguna",
    enfermedades: "Diabetes",
    medicamentos: "Insulina",
    resultado: "Controlada",
    observaciones: "Monitorización de glucosa"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5d"),
    alergias: "Nueces",
    enfermedades: "Celiaquía",
    medicamentos: "Sin gluten",
    resultado: "Controlada",
    observaciones: "Dieta sin gluten"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5e"),
    alergias: "Polen",
    enfermedades: "Artritis",
    medicamentos: "Diclofenaco",
    resultado: "Estable",
    observaciones: "Terapia física regular"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e5f"),
    alergias: "Ninguna",
    enfermedades: "Hipotiroidismo",
    medicamentos: "Levotiroxina",
    resultado: "Estable",
    observaciones: "Control hormonal"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e60"),
    alergias: "Ninguna",
    enfermedades: "Depresión",
    medicamentos: "Sertralina",
    resultado: "Controlada",
    observaciones: "Terapia psicológica regular"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e61"),
    alergias: "Ninguna",
    enfermedades: "Gastritis",
    medicamentos: "Omeprazol",
    resultado: "Estable",
    observaciones: "Dieta equilibrada"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e62"),
    alergias: "Ninguna",
    enfermedades: "Hipertensión",
    medicamentos: "Enalapril",
    resultado: "Estable",
    observaciones: "Control regular de presión arterial"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e63"),
    alergias: "Ninguna",
    enfermedades: "Migraña",
    medicamentos: "Sumatriptán",
    resultado: "Controlada",
    observaciones: "Evitar factores desencadenantes"
}
])

db.historial_medico_asegurados.find()

//esquema de validacion para agentes

db.createCollection("agentes", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["nombre", "apellido", "direccion", "telefono", "correo", "sueldo", "comision", "historial_ventas", "sucursal", "polizas"],
            properties: {
                nombre: {
                    bsonType: "string",
                    description: "Nombre del agente"
                },
                apellido: {
                    bsonType: "string",
                    description: "Apellido del agente"
                },
                direccion: {
                    bsonType: "string",
                    description: "Dirección del agente"
                },
                telefono: {
                    bsonType: "string",
                    description: "Teléfono del agente"
                },
                correo: {
                    bsonType: "string",
                    description: "Correo del agente"
                },
                f_nacimiento: {
                    bsonType: "date",
                    description: "Fecha de nacimiento del agente"
                },
                estado_civil: {
                    bsonType: "string",
                    description: "Estado civil del agente"
                },
                sexo: {
                    bsonType: "string",
                    description: "Sexo del agente"
                },
                historial_ventas: {
                    bsonType: "array",
                    description: "Historial de ventas del agente"
                },
                sueldo: {
                    bsonType: "int",
                    description: "Sueldo del agente"
                },
                comision: {
                    bsonType: "int",
                    description: "Comisión del agente"
                },
                sucursal: {
                    bsonType: "object",
                    required: ["ubicacion", "telefono"],
                    properties: {
                        ubicacion: {
                            bsonType: "string",
                        },
                        telefono: {
                            bsonType: "string",
                        },
                    }
                },
                polizas: {
                    bsonType: "objectId",
                    description: "Polizas del agente"
                }
            }
        }
    }
})

db.agentes.insertMany([
{
    nombre: "María",
    apellido: "López",
    direccion: "Calle Principal 123",
    telefono: "123456789",
    correo: "maria@gmail.com",
    sueldo: 5000,
    comision: 10,
    historial_ventas: [ ],
    sucursal: {
        ubicacion: "Chorrillos",
        telefono: "987654321"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e6f")
},
{
    nombre: "Juan",
    apellido: "García",
    direccion: "Avenida Secundaria 456",
    telefono: "987654321",
    correo: "juan@gmail.com",
    sueldo: 5500,
    comision: 8,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Barranco",
        telefono: "123456789"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e70")
},
{
    nombre: "Laura",
    apellido: "Martínez",
    direccion: "Calle Principal 789",
    telefono: "456789123",
    correo: "laura@gmail.com",
    sueldo: 6000,
    comision: 120,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Comas",
        telefono: "987654321"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e71")
},
{
    nombre: "Pedro",
    apellido: "Rodríguez",
    direccion: "Avenida Secundaria 147",
    telefono: "321654987",
    correo: "pedro@gmail.com",
    sueldo: 5500,
    comision: 100,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Miraflores",
        telefono: "456789123"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e72")
},
{
    nombre: "Ana",
    apellido: "González",
    direccion: "Calle Principal 789",
    telefono: "789654123",
    correo: "ana@gmail.com",
    sueldo: 6000,
    comision: 800,
    historial_ventas: [],
    sucursal: {
        ubicacion: "San Isidro",
        telefono: "987654321"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e73")
},
{
    nombre: "Carlos",
    apellido: "Hernández",
    direccion: "Avenida Secundaria 456",
    telefono: "456321987",
    correo: "carlos@gmail.com",
    sueldo: 5500,
    comision: 120,
    historial_ventas: [],
    sucursal: {
        ubicacion: "San Borja",
        telefono: "123456789"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e74")
},
{
    nombre: "Sofía",
    apellido: "Fernández",
    direccion: "Calle Principal 123",
    telefono: "321987654",
    correo: "sofia@gmail.com",
    sueldo: 5000,
    comision: 100,
    historial_ventas: [],
    sucursal: {
        ubicacion: "San Miguel",
        telefono: "789654123"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e75")
}
,
{
    nombre: "Diego",
    apellido: "Gómez",
    direccion: "Avenida Secundaria 147",
    telefono: "789321654",
    correo: "diego@gmail.com",
    sueldo: 6000,
    comision: 800,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Surco",
        telefono: "456789123"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e76")
},
{
    nombre: "Laura",
    apellido: "Ramírez",
    direccion: "Calle Principal 789",
    telefono: "987321654",
    correo: "laura@gmail.com",
    sueldo: 5500,
    comision: 120,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Lima",
        telefono: "987654321"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e77")
},
{
    nombre: "Pablo",
    apellido: "Silva",
    direccion: "Avenida Secundaria 456",
    telefono: "654321987",
    correo: "pablo@gmail.com",
    sueldo: 6000,
    comision: 100,
    historial_ventas: [],
    sucursal: {
        ubicacion: "Callao",
        telefono: "456789123"
    },
    polizas: ObjectId("60d3c9e81959d61f8d4e4e78")
}
])

db.agentes.find()

db.agentes.deleteMany({})

//esquema de validacion para polizas

db.createCollection("polizas", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id_asegurado", "id_agente", "descripcion", "monto", "prima", "fecha_inicio", "fecha_fin"],
            properties: {
                id_asegurado: {
                    bsonType: "objectId",
                    description: "ID del asegurado"
                },
                id_agente: {
                    bsonType: "objectId",
                    description: "ID del agente"
                },
                descripcion: {
                    bsonType: "string",
                    description: "Descripción de la póliza"
                },
                monto: {
                    bsonType: "double",
                    description: "Monto de la póliza"
                },
                prima: {
                    bsonType: "double",
                    description: "Prima de la póliza"
                },
                fecha_inicio: {
                    bsonType: "string",
                    description: "Fecha de inicio de la póliza"
                },
                fecha_fin: {
                    bsonType: "string",
                    description: "Fecha de fin de la póliza"
                }
            }
        }
    }
})

db.polizas.insertMany([
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e6f"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e7f"),
    descripcion: "Póliza de vida",
    monto: 15000.90,
    prima: 500.50,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e70"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e80"),
    descripcion: "Póliza de automóvil",
    monto: 1000.80,
    prima: 300.60,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e71"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e81"),
    descripcion: "Póliza de hogar",
    monto: 15000.40,
    prima: 500.20,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e72"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e82"),
    descripcion: "Póliza de vida",
    monto: 50000.40,
    prima: 700.30,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e73"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e83"),
    descripcion: "Póliza de automóvil",
    monto: 30000.99,
    prima: 2000.30,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e74"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e84"),
    descripcion: "Póliza de hogar",
    monto: 20000.10,
    prima: 300.30,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e75"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e85"),
    descripcion: "Póliza de vida",
    monto: 25000.90,
    prima: 400.10,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e76"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e86"),
    descripcion: "Póliza de automóvil",
    monto: 10000.50,
    prima: 200.40,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e77"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e87"),
    descripcion: "Póliza de hogar",
    monto: 18000.40,
    prima: 400.80,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
},
{
    id_asegurado: ObjectId("60d3c9e81959d61f8d4e4e78"),
    id_agente: ObjectId("60d3ca431959d61f8d4e4e88"),
    descripcion: "Póliza de vida",
    monto: 30000.50,
    prima: 250.99,
    fecha_inicio: "2023-07-01",
    fecha_fin: "2024-07-01"
}
])

db.polizas.find()
