from utils import CanadianJurisdiction


class Guelph(CanadianJurisdiction):
  jurisdiction_id = u'ocd-jurisdiction/country:ca/csd:3523008/council'
  geographic_code = 3523008

  def _get_metadata(self):
    return {
      'division_name': 'Guelph',
      'name': 'Guelph City Council',
      'url': 'http://guelph.ca',
    }
