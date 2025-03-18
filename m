Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2031.outbound.protection.outlook.com [40.92.18.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0162063D3
	for <autofs@vger.kernel.org>; Tue, 18 Mar 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333628; cv=fail; b=iHBeD0lQ810BLPgEXmlmLJgV2wwv3WNaz8+meMxuxo5Sg66Vdc54qecjIKP/uGCYvy4VFftKe3bF9/GH+g5ybzXAjDPpcH6w53helE4j+Srj9DQ9W2t4XksAjI0c/JcfuZWrGjIXlWqs2BWi0uczehAbMgAr/ohfezrivanzgCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333628; c=relaxed/simple;
	bh=+2oibd9dcgXUaMF4vgCyxKBfgmj616C43LtjCQQ6OWQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lG+2skyTtPYPG5JNfMuefumqMl21C547Fcf2d35CI+P7jc9+1PokugWwXAHOBFvrKfvxFUpq9wBbcZGmiZB4akMoumwgcrJ9WUILA3q9wXUWcNhmu7OF39SjMpcpfpHf+kw9QtnpouccM8i5cwMsfjuDQJE0Bw1QXv9VNuFOD8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Hunof3mP; arc=fail smtp.client-ip=40.92.18.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Hunof3mP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaatoC6SIvqfjsMQH4emEZzwpxEYnXQ17TuFhSEjqDA58rq3GqZQpgIg12SFBHn/K92Kk/O83+xJp+gkhAvN2o7w3xnjHlR5JkDEWxf/50ukg1+0IfKb7FaoQ35FRfWNgh1TJKgPTdkIl40PCW5LyRx3MbbECTYtPJduRHo1p5YIGnc2f5ukMK5yZAe6qESh2c6Jh/mSFqlL/bkl2G5+IUN9UwMgePN6U9Z+vsQsw73smIEpZso+Y3hUy4NgTsLE21DtCENmxTvOY60CRwzA4cU/fft2qUQAcJppYmEFvtHsiUcBHiVDGjR7343lSmErDJvCi13nETCWi99Jo6cdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2oibd9dcgXUaMF4vgCyxKBfgmj616C43LtjCQQ6OWQ=;
 b=dqzqX4AhAa4xksZVwXyRwDrZE7miQ0wTExcHvGqgjvmJoAdIjmStaP5TfEGljIoHsxcM2SUwdWkQRIe5tlQ0W35kTrGKvv27quOnZcm0zTCAWoWa+GBiY0ME/Z+7ndgfltiTelRc6gY7nZCrllpLb0Rmv78TQGHxGApERf/3V7kXbc8jHuvHy5T3oSrbm/xOVEZzgbErZdx8o/qnr2rJRx5ETW0MuLJY16k1/VVQgqD9+t/V0U+sayqazgmy6D2obffUjwaxN9wLTY73KWt9gj+aJ6H+oQKdrZxmJfToJnC/igs5m+I7iy54kvRDMYki4RIDxeeevpNtt50YFl4cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2oibd9dcgXUaMF4vgCyxKBfgmj616C43LtjCQQ6OWQ=;
 b=Hunof3mPha3wton/nr1ZxKl6+tggHrwCHOC8IIC1lWxvkiDsvDAu1a0kFmWxa8qROXUGPtc0WRTL0l0V4eX1EqHqD4lZn8cYvnlTlufg3VhpBJ9rrlKnS2W8iy/w/eSw4ll6NaD/yeFMtv0sU76ybP8jxhkQe/vnoqf33d8hExtd1SXG82/zpAnt0RsDD8HXG+B75HgQCDRuHad+YClGFfTU8kyQg7nPYvABjmoacDGPweX7DIi3g3H5K+S8wisXKalzUyai8wL/MLQxiBuCwuyICnycNZ8Il0AitfzSkMaCfCnlylwvHQalet/gGna0M21zB712qaZgu5LUmx+ZEw==
Received: from SN7PR20MB6013.namprd20.prod.outlook.com (2603:10b6:806:350::14)
 by SJ0PR20MB6200.namprd20.prod.outlook.com (2603:10b6:a03:4ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:33:43 +0000
Received: from SN7PR20MB6013.namprd20.prod.outlook.com
 ([fe80::9903:7ca5:2:99c6]) by SN7PR20MB6013.namprd20.prod.outlook.com
 ([fe80::9903:7ca5:2:99c6%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:33:43 +0000
From: D VanBoom <dvboom@hotmail.com>
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>
Subject: Autofs indirect mount is not unmounting
Thread-Topic: Autofs indirect mount is not unmounting
Thread-Index: AQHbmE1XtKwy/L91uEWFZTxpjUHxSQ==
Date: Tue, 18 Mar 2025 21:33:43 +0000
Message-ID:
 <SN7PR20MB601313DD6874B80F0D8A9654D2DE2@SN7PR20MB6013.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR20MB6013:EE_|SJ0PR20MB6200:EE_
x-ms-office365-filtering-correlation-id: b63c07d3-9c38-4ead-65ac-08dd66648ec2
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|15080799006|461199028|8062599003|19110799003|8060799006|15030799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QPtIt7t++qgPZmq4u0WWXnMhGVhaBTpZehIRersRrNuBgN5yOFHeegJ5r1?=
 =?iso-8859-1?Q?0Zuz/nTOWzoAx2+NDFF0LBK7Xod9VU6rooiGAYPgi/IheKl9h9ZDu0mhQU?=
 =?iso-8859-1?Q?v9QhcD08TJbAcH5cpOwSRu/5K5rENZtYW8+Xr1jRlsKQnhgUoOJimMRaWF?=
 =?iso-8859-1?Q?PR5UZJCs6ANQ2Bti3jfTHSXWen9O21LfBnlqFY2d03wdTx7TNE+62r0X3p?=
 =?iso-8859-1?Q?lGPf8kiWKLnqtPVBzN6gkrIIxgbfsp3D2nRrhoaAaJKu7+ol4tLhloIIb5?=
 =?iso-8859-1?Q?wZy5krkfxMD0scDj5m+Oo1Z7U5XaJRg7Pp05KZa9Aok7KI5LlPfDleuula?=
 =?iso-8859-1?Q?6ahKj6t5lKUjpeuPaFM05dsRI3TCFYT3GU/Ky1N1Y+YBnqLAIgsKSur5j7?=
 =?iso-8859-1?Q?43LTxFw0TYoo60JtTkQ2SaapZ5gHRVn80TVFl2J+1YTgC0cNEgiO1NPm3P?=
 =?iso-8859-1?Q?TdpAqXj2+CeduWPv1f3A8zdnyG2rgCZapOuYWebynIPJgCEInEEUc1lZER?=
 =?iso-8859-1?Q?uETDqqr77EqPIRiToaTaTSGDNnrOoaHHOX+iFz/2H8fLj025wIA8qhKpzJ?=
 =?iso-8859-1?Q?J8ID2xJMhxJ1BuHUtp7M5klwssaFVjTArdkROA6djJzO5f4xAMs+kE+Fl1?=
 =?iso-8859-1?Q?cyXkXAIjV3qbIVmgpZ4EsDibW7npNGrsf09R5MZgcA7SqiqeH+t/Nq82WY?=
 =?iso-8859-1?Q?fdHmhMXN4EjOYopER1ovI+hqjjBIOFfSOJnexFNWDRgc7MsCkktFrZ835l?=
 =?iso-8859-1?Q?k4FlmqQnxKN7UMSbXCMYGcm/ZQIjtz7jaDDUoP5jGDq+jWFKuwI3ub3+My?=
 =?iso-8859-1?Q?zBRE5/7uDlFBHX69cZYnbqnnhLk1+ypDlYFWdeuesac2/VLwNrAxSxWl6L?=
 =?iso-8859-1?Q?mNdugoRnzOIXIpZLUsjRyCrHyJa70dmpzFnq//WLdJQkYaJbRxnzH31mNm?=
 =?iso-8859-1?Q?UYjRhyjYE3iDou4e1A7i/yGhdxZkg2T73ApNYkFT5Qmj5dzIlzqtV1NnFP?=
 =?iso-8859-1?Q?HcvS5DOrGYZjNAMrCWiKFJnvJ3ZGTjcuRog7ii7hQ8axxejB4b5jGPd3N8?=
 =?iso-8859-1?Q?rl1ZVNOZpdf7jBx9CFQLXOGInrbZ2/zITmFI/L6sO3gIAiYLO5M8C8KstR?=
 =?iso-8859-1?Q?qJge1FpPeCkK6A0/sINW0RCn6/fNQoH0KG0y7B5z29a+fCkAM585XUzS9Y?=
 =?iso-8859-1?Q?GV52VZDb1Hc6PA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L+dSSrczpwD1LGnzuxCtoKUoEva+CUakqGHQArqjmx41RZdcsVssmEW4G6?=
 =?iso-8859-1?Q?EiSBwy6yp8QSQ9tOxVY2l7hsQlLgrMaHKwL1atrz6hclAC+jafsUYTmW1n?=
 =?iso-8859-1?Q?r2GE1z2DDpqMYOP0RKaeHWvabariE+1PrtwEuL++PUcfSzsTGZ4XF4bQpb?=
 =?iso-8859-1?Q?aUAVQIlr01Ay8hEaycVC/9ZCkSCD6FySajncGxRYNubupvuKb+ozaukS1c?=
 =?iso-8859-1?Q?yp01Pbc3z81XVXMSMzyrsVOD+dB1ii7oCTOSH/g//azMZ3jDOXi02hgNbP?=
 =?iso-8859-1?Q?pf4svzLtBbo0hTJfeMLD1v5mZct1GEMnH/GOpaEfJhGhvl0AY1/yyCqsnx?=
 =?iso-8859-1?Q?8FOtgoQmjMl+8blRIJjDEvsV9n7wqQH6Iy020A89E+M9gGan+99U7gHdDY?=
 =?iso-8859-1?Q?t219OpoHXz4xzRlb63vY2N4vN9Zvbi/P0OyznqpYeeAIOXVCsq3+xYscJx?=
 =?iso-8859-1?Q?xfcBSIPBavFukDXgntvpSM/22k+6Ye9TMwOzcd6qULw3K1govKjbbcvsHo?=
 =?iso-8859-1?Q?9RFOsHfF9oKRFqq/BH650QikesjyUBRYQaXpGB1sHmJEYOlVWaOW6RpSyw?=
 =?iso-8859-1?Q?6h5HsjuO055yVNpOtUDacnmP21wq7LH7jGOJkUJWfZZX1Bcma5lrzkEtk/?=
 =?iso-8859-1?Q?ijCzNrotV6C4kDVm4Q8Y7Ql2HipvNheip6v/owycGlRkxHNOyrXTW/+fjz?=
 =?iso-8859-1?Q?AqJwcgUtN/JMmfzqdTd/MYP5KgoONGkR4lnOlsZPVIPMZnBS2MViYBqqEn?=
 =?iso-8859-1?Q?6H3O3Z27/qLANAuIGky1OFKmanCmGr/lFwmgrF5oJZh0f6Di5ikYCBR2II?=
 =?iso-8859-1?Q?YwQBjTgQ8Ddbn46Gw5y2Wo4mBHUlDRBv1tZoBwmyqXS/owYodvskDUqasO?=
 =?iso-8859-1?Q?/kVv1/rVzGsKWvvWs7CRnKuDmEBSwOicKdLLUXAPfNGGobeoP1CsptbhNz?=
 =?iso-8859-1?Q?eyRShnlGZtzLs97e8PSJ/UN518xhM80EnR6levQ+oQHPeh3fuIGUKxOJSV?=
 =?iso-8859-1?Q?+5CnhB1DEagurmtKrnx6ngcrvrSdrgI2pr+umHYTlObJkdkZW8zWXaKl1m?=
 =?iso-8859-1?Q?MONopwnG2AJ05Xe8hjOyDygBDWoq5x/vtp/eWTazBs0nZfecgBiD17gFo+?=
 =?iso-8859-1?Q?BtgmvNK61JMPJm25101g8ysGCbXhemJBY1gyDaVC4oC1RnNCv8omYdZrLc?=
 =?iso-8859-1?Q?eFF8br71/hRbWG3ciaKZZnhB8A39WfJhCytYcq5R1Yj2LQQ609OiKgMebo?=
 =?iso-8859-1?Q?0Ewn2f0V2RwvcX2Gz+nw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR20MB6013.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b63c07d3-9c38-4ead-65ac-08dd66648ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 21:33:43.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB6200

Hello,=0A=
I am attempting a simple configuration under Debian 12, autofs 5.1.18.=0A=
=0A=
In /etc/auto.master.d/fortknox.autofs=0A=
/fortknox=A0=A0=A0 /etc/auto.forknox=A0=A0 --timeout=3D20=0A=
=0A=
In /etc/auto.fortknox=0A=
backups -rw,vers=3D4 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.=
0.10:/backups=0A=
=0A=
I can easily get it to automount with "ls /fortknox/backups"=0A=
=0A=
But watching the mounts, it never unmounts.=0A=
=0A=
lsof +D /fortknox/backups shows nothing.=0A=
lsof +D /fortknox shows that automount is accessing that path.=0A=
=0A=
I have made no changes to /etc/autofs.conf or any other config file except =
browse_mode =3D yes.=0A=
=0A=
I hope I am missing something simple, but after days of attempts I think I =
may have exhausted all configuration options.=A0=0A=
=0A=
Is this a known issue that may be resolved in 5.1.19?=0A=
=0A=
Thank you!=0A=
Don=0A=
=0A=
