package com.hk.nai.dtos;

public class RankingDto {
	
	private String rankAcademyName;
	private float rankScoreAverage;
	
	public RankingDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public String getRankAcademyName() {
		return rankAcademyName;
	}


	public void setRankAcademyName(String rankAcademyName) {
		this.rankAcademyName = rankAcademyName;
	}


	public float getRankScoreAverage() {
		return rankScoreAverage;
	}


	public void setRankScoreAverage(float rankScoreAverage) {
		this.rankScoreAverage = rankScoreAverage;
	}


	@Override
	public String toString() {
		return "RankingDto [rankAcademyName=" + rankAcademyName + ", rankScoreAverage=" + rankScoreAverage + "]";
	}

}
