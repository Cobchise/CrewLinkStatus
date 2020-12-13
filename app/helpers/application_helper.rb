module ApplicationHelper
    def printRegion(region, id)
        case region
        when "North America"
            "<i class='fas fa-globe-americas mr-1'></i><span id='region-#{id}'>NA</span>"
        when "Europe"
            "<i class='fas fa-globe-europe mr-1'></i><span id='region-#{id}'>EU</span>"
        when "Oceania"
            "<i class='fas fa-globe-asia mr-1'></i><span id='region-#{id}'>OCE</span>"
        else
            "Unknown"
        end
    end
end
