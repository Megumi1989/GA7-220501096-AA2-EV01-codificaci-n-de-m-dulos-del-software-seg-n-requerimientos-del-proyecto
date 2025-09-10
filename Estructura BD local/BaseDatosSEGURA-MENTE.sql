USE `jdbctest` ;
CREATE TABLE IF NOT EXISTS `jdbctest`.`Usuarios` (
  `idUsuario` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) BINARY NULL,
  `FechaNacimiento` DATE NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Contrasena` VARCHAR(45) NOT NULL,
  `FechaRegistro` DATE NOT NULL,
  `EstadoUsuario` ENUM("Activo", "Inactivo") NOT NULL,
  `Rol` ENUM("administrador", "psicologo", "paciente") NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`Servicios_psicologicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`Servicios_psicologicos` (
  `idServicio` INT NOT NULL AUTO_INCREMENT,
  `nombreServicio` VARCHAR(45) NOT NULL,
  `descripcionServicio` TEXT NULL,
  `precioServicio` FLOAT NOT NULL,
  `estadoServicio` ENUM("Disponible", "No Disponible") NOT NULL,
  PRIMARY KEY (`idServicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`Pagos` (
  `idPago` INT NOT NULL AUTO_INCREMENT,
  `fechaPago` DATE NOT NULL,
  `horaPago` TIME NOT NULL,
  `medioPago` ENUM('PSE', 'Tarjeta') NOT NULL,
  `montoTotal` FLOAT NOT NULL,
  `estado` ENUM('Pendiente', 'Completado', 'Fallido') NOT NULL,
  `resultado` VARCHAR(45) NULL,
  PRIMARY KEY (`idPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`Citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`Citas` (
  `idCita` INT NOT NULL AUTO_INCREMENT,
  `estadoCita` ENUM('Pendiente', 'Cancelada', 'Completada') NOT NULL,
  `motivoCancelacion` VARCHAR(250) NULL,
  `Servicios_psicologicos_idServicio` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Pago_idPago` INT NOT NULL,
  `Disponibilidades_idDisponibilidad` INT NOT NULL,
  `Fecha` DATE NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  PRIMARY KEY (`idCita`, `Pago_idPago`, `Disponibilidades_idDisponibilidad`),
  INDEX `fk_cita_Servicios psicologicos1_idx` (`Servicios_psicologicos_idServicio` ASC) VISIBLE,
  INDEX `fk_cita_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_cita_Pago1_idx` (`Pago_idPago` ASC) VISIBLE,
  CONSTRAINT `fk_cita_Servicios psicologicos`
    FOREIGN KEY (`Servicios_psicologicos_idServicio`)
    REFERENCES `jdbctest`.`Servicios_psicologicos` (`idServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cita_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `jdbctest`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cita_Pago1`
    FOREIGN KEY (`Pago_idPago`)
    REFERENCES `jdbctest`.`Pagos` (`idPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`Tecnicas_Relajacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`Tecnicas_Relajacion` (
  `idTecnicaRelajacion` INT NOT NULL,
  `nombreTecnica` VARCHAR(45) NOT NULL,
  `URLVideoGuia` VARCHAR(200) NOT NULL,
  `fechaUltimaModificacion` DATETIME NOT NULL,
  PRIMARY KEY (`idTecnicaRelajacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`imagenes_Fondo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`imagenes_Fondo` (
  `idImgFondo` INT NOT NULL,
  `nombreImagen` VARCHAR(45) NOT NULL,
  `URL_Imagen` VARCHAR(200) NOT NULL,
  `fechaSubidaImagen` DATETIME NOT NULL,
  PRIMARY KEY (`idImgFondo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`Lugares_Seguros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`Lugares_Seguros` (
  `idMiLugarSeguro` INT NOT NULL,
  `tecnicasDeRelajacion_idTecnicaRelajacion` INT NOT NULL,
  `imagenesFondo_idImgFondo` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idMiLugarSeguro`),
  INDEX `fk_miLugarSeguro_tecnicasDeRelajacion1_idx` (`tecnicasDeRelajacion_idTecnicaRelajacion` ASC) VISIBLE,
  INDEX `fk_miLugarSeguro_imagenesFondo1_idx` (`imagenesFondo_idImgFondo` ASC) VISIBLE,
  INDEX `fk_miLugarSeguro_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_miLugarSeguro_tecnicasDeRelajacion1`
    FOREIGN KEY (`tecnicasDeRelajacion_idTecnicaRelajacion`)
    REFERENCES `jdbctest`.`Tecnicas_Relajacion` (`idTecnicaRelajacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_miLugarSeguro_imagenesFondo1`
    FOREIGN KEY (`imagenesFondo_idImgFondo`)
    REFERENCES `jdbctest`.`imagenes_Fondo` (`idImgFondo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_miLugarSeguro_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `jdbctest`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`factura` (
  `idFactura` INT NOT NULL,
  `montoTotal` DECIMAL(10,5) NOT NULL,
  `fechaFactura` DATE NOT NULL,
  `horaGeneracionFactura` TIME NOT NULL,
  `cita_idCita` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_factura_cita1_idx` (`cita_idCita` ASC) VISIBLE,
  CONSTRAINT `fk_factura_cita1`
    FOREIGN KEY (`cita_idCita`)
    REFERENCES `jdbctest`.`Citas` (`idCita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`psicologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`psicologo` (
  `idPsicologo` INT NOT NULL,
  PRIMARY KEY (`idPsicologo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`paciente` (
  `idPaciente` INT NOT NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`agenda` (
  `idAgenda` INT NOT NULL,
  PRIMARY KEY (`idAgenda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jdbctest`.`serviciosPsicologicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jdbctest`.`serviciosPsicologicos` (
  `idServicio` INT NOT NULL,
  PRIMARY KEY (`idServicio`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

