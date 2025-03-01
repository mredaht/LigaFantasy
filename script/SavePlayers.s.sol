// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SavePlayers {
    struct PlayerData {
        string name;
        string team;
    }

    function getPlayers() public pure returns (PlayerData[] memory) {
        PlayerData[] memory players;

        // Barcelona
        players[0] = PlayerData("Lewandowski", "Barcelona");
        players[1] = PlayerData("Pedri", "Barcelona");
        players[2] = PlayerData("Gavi", "Barcelona");
        players[3] = PlayerData("Ter Stegen", "Barcelona");
        players[4] = PlayerData("De Jong", "Barcelona");
        players[5] = PlayerData("Araujo", "Barcelona");
        players[6] = PlayerData("Raphinha", "Barcelona");
        players[7] = PlayerData("Cubarsi", "Barcelona");
        players[8] = PlayerData("Kounde", "Barcelona");
        players[9] = PlayerData("Lamine Yamal", "Barcelona");
        players[10] = PlayerData("Balde", "Barcelona");

        // Real Madrid
        players[11] = PlayerData("Bellingham", "Real Madrid");
        players[12] = PlayerData("Vinicius", "Real Madrid");
        players[13] = PlayerData("Rodrygo", "Real Madrid");
        players[14] = PlayerData("Mbappe", "Real Madrid");
        players[15] = PlayerData("Modric", "Real Madrid");
        players[16] = PlayerData("Courtois", "Real Madrid");
        players[17] = PlayerData("Camavinga", "Real Madrid");
        players[18] = PlayerData("Rudiger", "Real Madrid");
        players[19] = PlayerData("Valverde", "Real Madrid");
        players[20] = PlayerData("Mendy", "Real Madrid");
        players[21] = PlayerData("Alaba", "Real Madrid");

        // Atletico Madrid
        players[22] = PlayerData("Griezmann", "Atletico Madrid");
        players[23] = PlayerData("Julian Alvarez", "Atletico Madrid");
        players[24] = PlayerData("Barrios", "Atletico Madrid");
        players[25] = PlayerData("Oblak", "Atletico Madrid");
        players[26] = PlayerData("Lenglet", "Atletico Madrid");
        players[27] = PlayerData("Gimenez", "Atletico Madrid");
        players[28] = PlayerData("Llorente", "Atletico Madrid");
        players[29] = PlayerData("De paul", "Atletico Madrid");
        players[30] = PlayerData("Giuliano", "Atletico Madrid");
        players[31] = PlayerData("Samuel Lino", "Atletico Madrid");
        players[32] = PlayerData("Le Normand", "Atletico Madrid");

        // Athletic Bilbao
        players[33] = PlayerData("Nico Williams", "Athletic Bilbao");
        players[34] = PlayerData("Unai Simon", "Athletic Bilbao");
        players[35] = PlayerData("Vivian", "Athletic Bilbao");
        players[36] = PlayerData("De Marcos", "Athletic Bilbao");
        players[37] = PlayerData("Yuri", "Athletic Bilbao");
        players[38] = PlayerData("Inaki Williams", "Athletic Bilbao");
        players[39] = PlayerData("Berenguer", "Athletic Bilbao");
        players[40] = PlayerData("Yeray", "Athletic Bilbao");
        players[41] = PlayerData("Sancet", "Athletic Bilbao");
        players[42] = PlayerData("Jaureguizar", "Athletic Bilbao");
        players[43] = PlayerData("Prados", "Athletic Bilbao");

        //VillaReal
        players[44] = PlayerData("Gueye", "VillaReal");
        players[45] = PlayerData("Kiko Femenia", "VillaReal");
        players[46] = PlayerData("Diego Conde", "VillaReal");
        players[47] = PlayerData("Sergi Cardona", "VillaReal");
        players[48] = PlayerData("Foyth", "VillaReal");
        players[49] = PlayerData("Parejo", "VillaReal");
        players[50] = PlayerData("Alex Baena", "VillaReal");
        players[51] = PlayerData("Logan Costa", "VillaReal");
        players[52] = PlayerData("Yeremi Pino", "VillaReal");
        players[53] = PlayerData("Ayoze Perez", "VillaReal");
        players[54] = PlayerData("Barry", "VillaReal");

        //Rayo Vallecano
        players[55] = PlayerData("Batalla", "Rayo Vallecano");
        players[56] = PlayerData("Ratiu", "Rayo Vallecano");
        players[57] = PlayerData("Isi Palazon", "Rayo Vallecano");
        players[58] = PlayerData("Mumin", "Rayo Vallecano");
        players[59] = PlayerData("Lejeune", "Rayo Vallecano");
        players[60] = PlayerData("Chavarria", "Rayo Vallecano");
        players[61] = PlayerData("Alvaro Garcia", "Rayo Vallecano");
        players[62] = PlayerData("De Frutos", "Rayo Vallecano");
        players[63] = PlayerData("Nteka", "Rayo Vallecano");
        players[64] = PlayerData("Oscar Trejo", "Rayo Vallecano");
        players[65] = PlayerData("Ciss", "Rayo Vallecano");

        // Betis
        players[66] = PlayerData("Adrian", "Betis");
        players[67] = PlayerData("Sabaly", "Betis");
        players[68] = PlayerData("Llorente", "Betis");
        players[69] = PlayerData("Perraud", "Betis");
        players[70] = PlayerData("Cardoso", "Betis");
        players[71] = PlayerData("Bartra", "Betis");
        players[72] = PlayerData("Isco", "Betis");
        players[73] = PlayerData("Anthony", "Betis");
        players[74] = PlayerData("Jesus Rodriguez", "Betis");
        players[75] = PlayerData("Altimira", "Betis");
        players[76] = PlayerData("Vitor Roque", "Betis");

        // Mallorca
        players[77] = PlayerData("Greif", "Mallorca");
        players[78] = PlayerData("Maffeo", "Mallorca");
        players[79] = PlayerData("Valjent", "Mallorca");
        players[80] = PlayerData("Raillo", "Mallorca");
        players[81] = PlayerData("Mojica", "Mallorca");
        players[82] = PlayerData("Mascarell", "Mallorca");
        players[83] = PlayerData("Dani Rodriguez", "Mallorca");
        players[84] = PlayerData("Navarro", "Mallorca");
        players[85] = PlayerData("Muriqi", "Mallorca");
        players[86] = PlayerData("Darder", "Mallorca");
        players[87] = PlayerData("Samu Costa", "Mallorca");

        //Real Sociedad
        players[88] = PlayerData("Remiro", "Real Sociedad");
        players[89] = PlayerData("Aramburu", "Real Sociedad");
        players[90] = PlayerData("Aguerd", "Real Sociedad");
        players[91] = PlayerData("Zubeldia", "Real Sociedad");
        players[92] = PlayerData("Aihen", "Real Sociedad");
        players[93] = PlayerData("Brais Mendez", "Real Sociedad");
        players[94] = PlayerData("Sucic", "Real Sociedad");
        players[95] = PlayerData("Zubimendi", "Real Sociedad");
        players[96] = PlayerData("Sergio Gomez", "Real Sociedad");
        players[97] = PlayerData("Oyarzabal", "Real Sociedad");
        players[98] = PlayerData("Kubo", "Real Sociedad");

        // Celta
        players[99] = PlayerData("Guaita", "Celta");
        players[100] = PlayerData("Starfelt", "Celta");
        players[101] = PlayerData("Javi Rodriguez", "Celta");
        players[102] = PlayerData("Carreira", "Celta");
        players[103] = PlayerData("Marcos Alonso", "Celta");
        players[104] = PlayerData("Mingueza", "Celta");
        players[105] = PlayerData("Moriba", "Celta");
        players[106] = PlayerData("Fran Beltran", "Celta");
        players[107] = PlayerData("Swedberg", "Celta");
        players[108] = PlayerData("Borja Iglesias", "Celta");
        players[109] = PlayerData("Aspas", "Celta");

        // Sevilla
        players[110] = PlayerData("Nyland", "Sevilla");
        players[111] = PlayerData("Saul", "Sevilla");
        players[112] = PlayerData("Kike Salas", "Sevilla");
        players[113] = PlayerData("Bade", "Sevilla");
        players[114] = PlayerData("Pedrosa", "Sevilla");
        players[115] = PlayerData("Carmona", "Sevilla");
        players[116] = PlayerData("Sow", "Sevilla");
        players[117] = PlayerData("Gudelj", "Sevilla");
        players[118] = PlayerData("Lukebakio", "Sevilla");
        players[119] = PlayerData("Ruben Vargas", "Sevilla");
        players[120] = PlayerData("Isaac", "Sevilla");

        // Girona
        players[121] = PlayerData("Gazzaniga", "Girona");
        players[122] = PlayerData("Miguel Gutierrez", "Girona");
        players[123] = PlayerData("Arnau Martinez", "Girona");
        players[124] = PlayerData("Blind", "Girona");
        players[125] = PlayerData("Krejci", "Girona");
        players[126] = PlayerData("Van de Beek", "Girona");
        players[127] = PlayerData("Tsygankov", "Girona");
        players[128] = PlayerData("Bryan Gil", "Girona");
        players[129] = PlayerData("Danjuma", "Girona");
        players[130] = PlayerData("Yangel Herrera", "Girona");
        players[131] = PlayerData("David Lopez", "Girona");

        // Osasuna
        players[132] = PlayerData("Sergio Herrera", "Osasuna");
        players[133] = PlayerData("Areso", "Osasuna");
        players[134] = PlayerData("Bretones", "Osasuna");
        players[135] = PlayerData("Catena", "Osasuna");
        players[136] = PlayerData("Boyomo", "Osasuna");
        players[137] = PlayerData("Bryan", "Osasuna");
        players[138] = PlayerData("Budimir", "Osasuna");
        players[139] = PlayerData("Torro", "Osasuna");
        players[140] = PlayerData("Moncayola", "Osasuna");
        players[141] = PlayerData("Ruben Garcia", "Osasuna");
        players[142] = PlayerData("Aimar Oroz", "Osasuna");

        // Getafe
        players[143] = PlayerData("David Soria", "Getafe");
        players[144] = PlayerData("Juan Iglesias", "Getafe");
        players[145] = PlayerData("Alderete", "Getafe");
        players[146] = PlayerData("Djene", "Getafe");
        players[147] = PlayerData("Diego Rico", "Getafe");
        players[148] = PlayerData("Arrambari", "Getafe");
        players[149] = PlayerData("Milla", "Getafe");
        players[150] = PlayerData("Mayoral", "Getafe");
        players[151] = PlayerData("Juanmi", "Getafe");
        players[152] = PlayerData("Terrats", "Getafe");
        players[153] = PlayerData("Carles Perez", "Getafe");

        // Espanyol
        players[143] = PlayerData("Joan Garcia", "Espanyol");
        players[144] = PlayerData("Omar El Hilali", "Espanyol");
        players[145] = PlayerData("Kumbulla", "Espanyol");
        players[146] = PlayerData("Cabrera", "Espanyol");
        players[147] = PlayerData("Carlos Romero", "Espanyol");
        players[148] = PlayerData("Pol Lozano", "Espanyol");
        players[149] = PlayerData("Jofre", "Espanyol");
        players[150] = PlayerData("Puado", "Espanyol");
        players[151] = PlayerData("Kral", "Espanyol");
        players[152] = PlayerData("Roberto", "Espanyol");
        players[153] = PlayerData("Urko Gonzalez", "Espanyol");

        // Las Palmas
        players[154] = PlayerData("Cillessen", "Las Palmas");
        players[155] = PlayerData("Alex Suarez", "Las Palmas");
        players[156] = PlayerData("Mckenna", "Las Palmas");
        players[157] = PlayerData("Mika Marmol", "Las Palmas");
        players[158] = PlayerData("Essugo", "Las Palmas");
        players[159] = PlayerData("Alex Munoz", "Las Palmas");
        players[160] = PlayerData("Sandro", "Las Palmas");
        players[161] = PlayerData("Moleiro", "Las Palmas");
        players[162] = PlayerData("Fabio Silva", "Las Palmas");
        players[163] = PlayerData("Viti Rozada", "Las Palmas");
        players[164] = PlayerData("Manu Fuster", "Las Palmas");

        //Leganes
        players[165] = PlayerData("Dimitrovic", "Leganes");
        players[166] = PlayerData("Alti", "Leganes");
        players[167] = PlayerData("Juan Cruz", "Leganes");
        players[168] = PlayerData("Rosier", "Leganes");
        players[169] = PlayerData("Javi Hernandez", "Leganes");
        players[170] = PlayerData("Neyou", "Leganes");
        players[171] = PlayerData("Tapia", "Leganes");
        players[172] = PlayerData("Dani Raba", "Leganes");
        players[173] = PlayerData("Cisse", "Leganes");
        players[174] = PlayerData("Nastacic", "Leganes");
        players[175] = PlayerData("Diego Garcia", "Leganes");

        // Alaves
        players[176] = PlayerData("Sivera", "Alaves");
        players[177] = PlayerData("Tenaglia", "Alaves");
        players[178] = PlayerData("Abqar", "Alaves");
        players[179] = PlayerData("Mourino", "Alaves");
        players[180] = PlayerData("Diarra", "Alaves");
        players[181] = PlayerData("Joan Jordan", "Alaves");
        players[182] = PlayerData("Blanco", "Alaves");
        players[183] = PlayerData("Alena", "Alaves");
        players[184] = PlayerData("Carlos Vicente", "Alaves");
        players[185] = PlayerData("Kike Garcia", "Alaves");
        players[186] = PlayerData("Toni Martinez", "Alaves");

        // Valencia
        players[187] = PlayerData("Mamardashvilli", "Valencia");
        players[188] = PlayerData("Foulquier", "Valencia");
        players[189] = PlayerData("Diakhaby", "Valencia");
        players[190] = PlayerData("Tarrega", "Valencia");
        players[191] = PlayerData("Mosquera", "Valencia");
        players[192] = PlayerData("Pepelu", "Valencia");
        players[193] = PlayerData("Guerra", "Valencia");
        players[194] = PlayerData("Duro", "Valencia");
        players[195] = PlayerData("Rioja", "Valencia");
        players[196] = PlayerData("Gaya", "Valencia");
        players[197] = PlayerData("Sadiq", "Valencia");

        // Valladolid
        players[198] = PlayerData("Karl Hein", "Valladolid");
        players[199] = PlayerData("Luis Perez", "Valladolid");
        players[200] = PlayerData("Aznou", "Valladolid");
        players[201] = PlayerData("Anuar", "Valladolid");
        players[202] = PlayerData("Moro", "Valladolid");
        players[203] = PlayerData("Marcos Andre", "Valladolid");
        players[204] = PlayerData("Amallah", "Valladolid");
        players[205] = PlayerData("Comert", "Valladolid");
        players[206] = PlayerData("Grillistch", "Valladolid");
        players[207] = PlayerData("Sylla", "Valladolid");
        players[208] = PlayerData("Latasa", "Valladolid");

        return players;
    }
}
