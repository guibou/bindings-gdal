module OSR (
    SpatialReference
  , CoordinateTransformation
  , Projectable (..)

  , srsFromWkt
  , srsFromProj4
  , srsFromEPSG
  , srsFromXML

  , srsToWkt
  , srsToProj4
  , srsToXML

  , isGeographic
  , isLocal
  , isProjected
  , isSameGeogCS
  , isSame

  , getAngularUnits
  , getLinearUnits

  , coordinateTransformation
) where
import GDAL.Internal.OSR
