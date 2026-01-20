package;

class Paths
{
    public static function image(key:String) {
        return 'assets/images/$key.png';
    }

    public static function xml(key:String) {
        return 'assets/$key.xml';
    }

    public static function ogmo(key:String) {
        return 'assets/$key.ogmo';
    }

    public static function json(key:String) {
        return 'assets/$key.json';
    }
    
}