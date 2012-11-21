package nl.mineleni.cbsviewer.util;

/**
 * Numerieke constanten voor de applicatie.
 * 
 * @see StringConstants
 * @author mprins
 * @since 1.5
 * @note bevat de constanten en default waarden voor de applicatie
 */
public enum NumberConstants {
	/** straal voor een adres zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_ADRES(150),
	/** straal voor een postcode zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_POSTCODE(500),
	/** straal voor een plaats zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_PLAATS(3000),
	/** straal voor een gemeente zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_GEMEENTE(10000),
	/** straal voor een provincie zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_PROVINCIE(50000),
	/** straal voor een default zoekresultaat, waarde in meter. */
	OPENLS_ZOOMSCALE_STANDAARD(18750)/* 150000 ~ heel NL */,

	/** default x coordinaat. */
	DEFAULT_XCOORD(140000),
	/** default y coordinaat. */
	DEFAULT_YCOORD(462500),

	/** default font size, 12. */
	DEFAULT_FONT_SIZE(12);

	/** de waarde van dit object. */
	private final Number number;

	/**
	 * constructor.
	 * 
	 * @param number
	 *            the number
	 */
	NumberConstants(final Number number) {
		this.number = number;
	}

	/**
	 * Double value van dit object.
	 * 
	 * @return de waarde van dit object als double
	 * @see java.lang.Number#doubleValue()
	 */
	public double doubleValue() {
		return this.number.doubleValue();
	}

	/**
	 * Int value van dit object.
	 * 
	 * @return de waarde van dit object als integer
	 * @see java.lang.Number#intValue()
	 */
	public int intValue() {
		return this.number.intValue();
	}

	/**
	 * String value van dit object.
	 * 
	 * @return de waarde van dit object als string
	 * @see java.lang.Enum#toString()
	 * @see java.lang.Number#toString()
	 */
	@Override
	public String toString() {
		return this.number.toString();
	}
}
