# frozen_string_literal: true

module People
  module WithLocation
    extend ActiveSupport::Concern

    # https://epsg.io/4326
    WGS84_SRID = 4326
    DEFAULT_DISTANCE_IN_KM = 10_000

    included do
      scope :with_location, lambda { |person|
        where(person.radius_query)
      }

      def radius_query
        # https://postgis.net/docs/ST_Point.html
        # For geodetic coordinates, X is longitude and Y is latitude
        "ST_DWithin(
          lonlat::geography,
          'SRID=#{WGS84_SRID};POINT(#{longitude} #{latitude})'::geography,
          #{radius_in_meters})
          ".squish
      end

      # Add a virtual column to people query with the distance in
      # meters from a point to the list of people in the query
      #
      # @return RGeo::ActiveRecord::SpatialNamedFunction
      def distance_in_meters_field
        table = Arel::Table.new('people')
        table[:lonlat].st_distance(
          lonlat
        ).as('distance_in_meters')
      end

      private

      def longitude
        lonlat&.lon
      end

      def latitude
        lonlat&.lat
      end

      def radius_in_meters
        radius_in_km * 1000
      end

      def radius_in_km
        search_range_in_km || DEFAULT_DISTANCE_IN_KM
      end
    end
  end
end
