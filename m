Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358786;
	b=QiF03QfvMxnWcm3L8JrTNfK+J2ksAus/RZqRrDfz/+QVe4oZHKYm3bc09Ave/62X4ROf
	 BpWqJkWNM46iPDuEUkVXMZl8Zpi9PhorLuB9FWRznDJ1rklJrNYiPzhwazjLq51gnm6XM
	 biqPco3XTcLOUw3mVteJCXr1M+WCDclRtwYRwchrixNUr8/KBx763J5Ek42qWr19VaVrA
	 nLGubPyUXxs/bQ0sxQU5Ln1IZtrDotoI2eOb8/1DQFFzytbIiR8TEBilQ7WLaevNNcwFF
	 KOXGYrm3fY3HQRBgajNspFQa1dI4bdclwzpbAvKCLLyZltYTKVHI9nw8C8aCNws3qHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358786;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UfMS9THKpbF7IePfmYMNJOYd+4dRlEGY3IcCz2WF9Ug=;
	b=S4YeGbpqANiNcVuzDsrVa2RLtCZ9wVMANjb6EOCQMOZOUXbEQJA3evaudIPPBUhvUTji
	 /PkSpVmjFDJ80Oz3ESd8PXS3gKTUITsOR1AVwmpHRqTC02pkujSPzYU5cD8VYP7ln3IEG
	 qO7KAm1negPE1+WNXSKLvVBLTkMC3IEEi08tQYMMGzR98tf0dXEgSFhYgtbHx8NEA+d3k
	 xf5t4dIYJhdhltbYTkUn90OQxRFBv3ARDqmIIggASzmvmqtsU5HnMj1iW5tzHMYshI/4L
	 yspPjc3X2DHYtyVXwcrzszUBAeFVOGuwWoO002cZBxIT6iyeewiTzM2qqC3l5R2TWmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=kn5Of6AY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=x7xzO5t1;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CD606A31C
	for <autofs@vger.kernel.org>; Wed, 11 Nov 2026 00:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=kn5Of6AY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=x7xzO5t1
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C5EF41D00295
	for <autofs@vger.kernel.org>; Tue, 10 Nov 2026 19:59:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 19:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1794358784; x=1794445184; bh=Uf
	MS9THKpbF7IePfmYMNJOYd+4dRlEGY3IcCz2WF9Ug=; b=kn5Of6AYUxa7O2/Ze5
	vBZekAA8wQ+3ChmJ7FAuYQLYg5J68WrMxO0g1ITOj9jti6V3k3A4Q8iHpiC85SnD
	2qU4dYqLpB2AC15L2o2Hu1L10fGfCj/my1BAWUc/U6Kh8mSow/ZM0dSdBQ7/3wCx
	QAnNajwr3l1bn/sCKCNf2oSG2rmfa7Fh3intLz8uY70gTLfrz2g1COxLPfiHjq9F
	MCft6AyO2t8+4XPTw/+wapI9PMGgLYVjgrAqXh+01KXfTsoRyF3OSHs41N52ACiY
	dbdRUcdgVRcrzHpaqB62Az/jaFCnBXgNoK1aut38o9AzwnKL6VHljRvnu16LMmDY
	6V5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794358784; x=1794445184; bh=UfMS9THKpbF7IePfmYMNJOYd+4dR
	lEGY3IcCz2WF9Ug=; b=x7xzO5t1+4XPJtRKk6wNDDrQrDTwybwMT8IFT4j5ayPR
	tP7Mpk934fsZciWLh0KLvOmD8T9Z4V+v5xVsynxLbvaGUEBllj0iCNW/qw57v809
	TaKA4+wTAlGrzwuS8AABMKoJ4h7n2vxRaORuAjgbQ3ujLWajCDkK5CZA0pn/FPR1
	72OoV8xfSq7ywjv7SeHOVCwPFkunK3/aPLKz1GkQe78FgybkRD779L27j36zgw0t
	dhUAFdwACFxL0bKc9+Kz6b6iXe/hYta+aCbvTILRjvQ3ucmk3MwujQd4m2J5mjzl
	Nus8m1QIC2N1+4Iiy2YIekXV1nUmOibiEGnqMpakVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794358784; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sFvzraT3ZYrXL19uiajtTZdD2uHX9X8U5VnJJilDRYo0fAj
	gaIMJ9yLHeTbpsOeCDGgY0q3M430MQyVthYRL99BfIWZT4woodHnzWUa4DX1ZwgI
	BigEsfpTeuUYvFU/Dtw4MyyEZaxqrMbDZh8EsfqqOYS8WamfM/zjBElzEzSi65Qu
	42LASoUO2/E95llupems4fKaGu5U1SRGNrqAvWxyqWEZqpqiIa0h1GzKBDEcBacn
	FEiiT20/meu0TwAVdXVge+M3W1ltjl0AUVfacPRHgzgjMTAiN7Rgf2QGTsIGH+R9
	ghr9lqhyvO11P3ElJNQ7MQvm9klMfWj2tk1DSpA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=autocrypt,cc,content-transfer-encoding,content-type,date,
	feedback-id,from,message-id,mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EMkdHC20a5Q4XeO3VetGfeM6ogcaBjuWSjiCqkb4lOw=:UfMS9THKpbF7IePfmYMNJOYd+4dRlEGY3IcCz2WF9Ug=;
X-ME-Sender: <xms:AL7zagfzd6cGJmK59UUdkxVP3m-HdF7Iw-bv5Ry_Prf_QdqwH946WA>
    <xme:AL7zapGqC0r_ALaLEr_iiY1-6i7c2ct-qvd9SieKmfshc9YX_Zo50bi5xipQZowKa
    -Uv9voBK0YdZT3sVz2TE5OfVIBj6zB2bvy-xueMlsSMPuZZQwk>
X-ME-Received: <xmr:AL7zap149KCa7ei_tAsRetYGEjAkvP3R7Dcd6DdpXFNH-rPw_WdDN_p5pkzddq1z3TZQvaVf6gJGELNWNAEQLpTsVPpxE87bhn6fOOLcEyOlt9l6iQP9b0zZsg>
X-ME-Proxy-Cause: dmFkZTE7C3nBwYDnYzTdMsqhRAeYcjbgvuguCeGTxebJQUcN0Bh7U4NSUvJjvP5fRbxGKW
    mV1NAalXlbsogcujhWxlXMC2UOetQqxVm4dzcO3zW+DctCEx+RmA1kGJ9qe7uRvUxFkUcM
    uBc0c4HeZF5mCtmryd4ucLD7R3flVrdWfjwe6s4K4m5JRsgUSU7bxC4+y95aBXL2q9jDKP
    sF9cdzdAgdJDSjK7bENAI2Hc9ZvxHIIk66zhPARmkKUzZVrETkDSyrpj6y/XhmD71++jzq
    LZzWd33PYVpKtaTOHZqL83SpyBIHdbGAAqEIeeIn6Jl/QQULCpQhoiUW94dJ/qR6sqZZJv
    Q5radPq9NgtPdHLeF6Fig1MqiQYpyRttx7eWXVmv2I7JT8XDBya1VkOqD1LE8gvfmFKmLm
    ZntAd/q1EwNBKujyu6ygKznAtWhXOLkcidUKFULsTP0fkH9RnA8GfZ2P0XBkJZGFWhzBi2
    2eTOj2vpYgstoWVQhbhEY1BewnR1cQx/yny4j8EAeKOWlKOj0tqJIxv9KjU+5cQ0QqqMhC
    9r+vQ1a8RVwTSHPQZacrtBTuZemytTbO5+r1kj+LkWzNkGqlVPmZ4SVTggmQxWupQJVInB
    TJiDkkZf1wao5/msE8i4XXF9WQqpAQgJEIO9duhbh1KJPN5tXiRamC0kr/EQ
X-ME-Proxy: <xmx:AL7zahmT0QjNpn6OrfZ7AAvMc_6mJdq9PI9RaU_IFRsufIzdce3z_Q>
    <xmx:AL7zap_UhYkYQibQDBbA9FdyeIHX0EsO2dUtvGKaoYIBri17LvSyWQ>
    <xmx:AL7zamq7krMtdkNU2HTrbejAA9PcSVyq35uB12noxPB8ac3ALBdn-Q>
    <xmx:AL7zailQzFHKF1zNXHiyhvj-KOeYMMVljagso8dm6-dxNjm2Vk1TDw>
    <xmx:AL7zatz_cJwfRYKJyUZ4YF2t4oFtQk5JRbq7qD-oecrm58QCzZFj_Nbv>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 19:59:42 -0500 (EST)
Message-ID: <284733dcaa88894cd4691ab4d5abf64b484dd9b8.camel@themaw.net>
Subject: [ANNOUNCE] autofs 5.2.0 release
From: Ian Kent <raven@themaw.net>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	autofs@vger.kernel.org
Date: Wed, 11 Nov 2026 08:59:38 +0800
Autocrypt: addr=raven@themaw.net; prefer-encrypt=mutual;
 keydata=mQINBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH
 44oE7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TIgp
 cs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msNbDq5S0K
 2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQvzxjVyOu+WLGP
 Sj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/ZviekuGbj3XvFibVt2ecS
 87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNudWXx9/Q0qsWfvZw7hEdPdPR
 BmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5ZRnyaXyzwaCt6ETUHTslEaR9nOG6
 N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRHhQtFxdycIBpTlc59g7uIXzwRx65HJcyB
 flj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0f
 k18Q5MLj441yQARAQABtBtJYW4gS2VudCA8cmF2ZW5AdGhlbWF3Lm5ldD6JAjsEEwECACUCGwMGCw
 kIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPi
 LJ0EE9eJkyV1rqtzct5Ah9pu6LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UV
 CxERgQBOJcPrbgaeYZuaE4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjCl
 W3ifdD75gHlrU0VZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4
 W0VgpWczmAtHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+
 YK/0LQ2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPwDSMZ2
 NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVncOqyghSE69
 H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8J/tYvFMpag3nTeC
 3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0tBtJYW4gS2VudCA8aWtlbnRA
 cmVkaGF0LmNvbT6JAjgEEwECACIFAk6eM44CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJE
 Odnc4D1T9ipMWwP/1FJJWjVYZekg0QOBixULBQ9Gx2TQewOp1DW/BViOMb7uYxrlsnvE7TDyqw5yQ
 z6dfb8/b9dPn68qhDecW9bsu72e9i143Cd4shTlkZfORiZjX70196jr2LiI6L11uSoVhDGeikSdfR
 tNWyEwAx2iLstwi7FccslNE4cWIIH2v0dxDYSpcfMaLmT9a7fxdoMLW58nwIz0GxQs/2OMykn/VIS
 t25wrepmBiacWu6oqQrpIYh3jyvMQYTBtdalUDDJqf+WaUO3+sNFRRysLGcCvEnNuWC3CeTTqU74X
 TUhf4cmAOyk+seA3MkPyzjVFufLipoYcCnjUavsMKBXQ8SCVdDxYxZwS8/FOhB8J2fN8w6gC5uK0Z
 KAzTj2WhJdxGe+hjf7zdyOcxMl5idbOOFu5gIm0Y5Q4mXz4q5vfjRlhQKvcqBc2HBTlI6xKAP/nxC
 AH4VzR5J9fhqxrWfcoREyUFHLMBuJGCRWxN7ZQoTYYPl6uTRVbQMfr/tEck2IWsqsqPZsV63zhGLW
 VufBxg88RD+YHiGCduhcKica8UluTK4aYLt8YadkGKgy812X+zSubS6D7yZELNA+Ge1yesyJOZsbp
 ojdFLAdwVkBa1xXkDhHBK0zUFE08obrnrEUeQDxAhIiN9pctG0nvqyBwTLGFoE5oRXJbtNXcHlEYc
 Uxl8BimQGiBD9WGTURBACdm5r0nReZVq2zFckHVM2Jt+1i7LqAWhtDOsCzQXno2RZrVCDMoAtxXEM
 xqfKf8CPBrWxWhs/9z8BqOKEIG/93mJST+w8XgGsVmDTBlNHxsSA1lfQQSGoRb/qOXQrdnr0SZo7s
 UPRC6Xo5wQl1T3GAEY3PMjGi/LemAHGJBA4crwCguNMo/kaPUjMU060+jSYtpY+oMTsEAJtvUoypr
 i3FY6dTgbdPj3dbCbfvkneDCTVOBAZKHUen1VzYvA6slmu1cY9j1VVZtmVbyZdCzCE+eN2qwj3BN4
 BYbPshytlBCDIc4wHFrSBb+TR/798y1BNC56EcgyPrlDPZMq3Qqm6dNpmqd57bHy/EjW4ohLzjN8F
 jCkdKKD3bA/9cOnH2eLxGXSCkEXN6PIv7F1kb2Jlq+AEktianPIMXAAbgAd/2BkAQQjmfJa16vO1q
 7vfb99YYP6a7X72u81F6CUqyLYbfr6OFibaYlFUFjfFNO+FcFLbeIi33LexDAatkvNWrjas+j4dW+
 QUd3X6clWk++unXopqvuISJ7ymooLQbSWFuIEtlbnQgPGlrZW50QHJlZGhhdC5jb20+iF4EExECAB
 4FAkPp/6sCGyMGCwkIBwMCAxUCAwMWAgECHgECF4AACgkQeWZm7NS+6YnnKgCeIUAAws0mlq171TX
 C4dnson+aVocAn045oaz0INt+kumeXNAWHDkyM8nitBtJYW4gS2VudCA8cmF2ZW5AdGhlbWF3Lm5l
 dD6IXAQTEQIAHAQLBwMCAxUCAwMWAgECHgECF4AFAkO5FgICGQEACgkQeWZm7NS+6YlQKACguFPsv
 2lDpFCd/0x49XjgPp5KhfMAnimiDYk9Va36ZsYXVrM1hVy+wkPhtCBJYW4gS2VudCA8cmF2ZW5AaG
 VyYS5rZXJuZWwub3JnPoheBBMRAgAeBQJDUcoVAhsjBgsJCAcDAgMVAgMDFgIBAh4BAheAAAoJEHl
 mZuzUvumJNNkAni8tvmTwGuLB2QMBY9Hs/hxaeXGsAJ0Ts2f5bmhQ2aEdofUYeuqefzlNLw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45app1) 
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi all,

A release is long overdue so here it is, autofs-5.2.0.

There are quite a lot of changes in the release which are composed of
bug fixes, general infrastructure imporovements and fixes arising from
some of the improvements.

I was hoping to include an initial implementation of a automount
network
management utility but there's still more to do on it. Specifically the
authentiaction is not yet ok and the reporting output also needs more
work. Not only that there's also a need to work with upstream selinux
folks due to changes for the utility rather than expect the downstream
maintainers to fix it after the fact.

autofs
=3D=3D=3D=3D=3D=3D

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.2.0.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.9.tar.gz

and the binary rpm can be built by using:

rpmbuild -tb autofs-5.1.9.tar.gz=20

Note that some of the foreign language descriptions in the spec file
cuase a problem which iis easily fixed by removing them:

Here are the entries from the CHANGELOG which outline the updates:

- Update configure script.
- fix ldap_parse_page_control() check.
- fix crash in make_options_string().
- Fix incompatible function pointer types in cyrus-sasl module.
- fix always recreate credential cache.
- fix amd external mount error handling.
- fix amd external mount mount handling.
- don't free ext mount if mounted.
- refactor amd function do_program_mount().
- refactor umount_amd_ext_mount().
- add flags argument to amd do_program_mount().
- fix amd cache options not copied.
- seperate amd mount and entry flags.
- make iocl ops ->timeout() handle per-dentry expire.
- refactor amd mount options handling.
- add some unimplemented amd map options.
- fix get parent multi-mount check in try_remount().
- fix deadlock in remount.
- Remove mentioning of nonstrict option in comment in samples/auto.net.
- Use AUTOFS_ prefixed environment variables in sample/auto.smb.
- man/autofs.conf.5: fix manpage formatting.
- fix memory leak in cache_release().
- fix submount shutdown race.
- fix lookup search type in umount_subtree_mounts().
- fix remount_active_mount() not remounting symlinks.
- log when setting amd per-mount timeout.
- update per-mount expire timeout on readmap.
- clear per-mount timeout if not set.
- handle sss special case getautomntbyname() error.
- fix deadlock in master_notify_submount().
- remove mounts_mutex macros.
- fix lock not released on error in mnts_add_amdmount().
- fix lock ordering deadlock in expire_cleanup().
- fix handling of ignored offsets.
- fix invalidated map entry handling in hosts module.
- dont call mkdir if dir exists.
- check map source in master_parse_entry().
- fix possible memory leak in mnts_get_expire_list().
- fix uninitialised list in struct master_mapent.
- fix tsv memory leak in set_tsd_user_vars().
- fix dont delay expire.
- make mnts_has_mounted_mounts() check submounts.
- fix string length check in merge_options()
- dont initialize hosts list in add_host().
- initialise process variables in log_pidinfo().
- fix incorrect error handling in sasl_do_kinit_ext_cc().
- fix off by one error in macro_init().
- fix incorrect allocation in match_key().
- dont use alloca for nfsoptions.
- fix type mismatch in mount_autofs_direct().
- fix multiply defined proximity.
- fix incorrect call in dev_ioctl_requester().
- use nobind instead of nosymlink.
- make rmdir_path() more informative.
- remove unused master map field.
- fix error return in do_mount_indirect().
- use sizeof for buffer length in set_log_priority.
- fix sublink option check length in update_with_defaults().
- dont assume non null tree node in tree_free().
- add missing cache_unlock() in umount_subtree_mounts().
- move open close on exec functions to autofs library.
- fix locking when setting master map reading.
- eliminate master map parameter where possible.
- refactor umount_subtree_mounts().
- fix indirect expire's count of remaining mounts.
- fix leak with non-strict mount fails.
- fix timed_read() error return.
- fix state queue not processing state changes.
- refactor mnts_get_expire_list().
- add en extra logging entry to tree_mapent_mount_offsets().
- quiet possibly noisy log message.
- fix devid update on reload.
- fix cache writelock must be taken in update_map_cache().
- fix skip valid map entries on expire cleanup.
- remove unnecessary call to set_direct_mount_tree_catatonic().
- remove unnecessary assignment in umount_multi().
- fix direct mount trigger umount failure case.
- refactor do_umount_autofs_direct().
- fix stale direct mount trigger not umounted on expire.
- add function table_lookup_ino().
- improve handling of missing map entry for mount request.
- fix incorrect flags update in update_with_defaults().
- skip expire check for amd nounmount mounts.
- Fix masks in parse_sub.c, so that hosts are correctly matched.
- fix fields not freed in clear_amd_entry().
- initialise fields after free in clear_amd_entry().
- fix some fields not copied in dup_defaults_entry().
- do_reconnect() expiry check of dclist BEFORE lookup using it.
- fix mailing list subscription address.
- fix table_lookup_ino() fd reference.
- fix handling of direct mount path in command handler.
- fix useless complexity in get_proximity().
- fix buffer overflow in prepend_opt().
- fix lookup_hosts module leaks read lock on early return.
- quiet unset environment variable message on start.
- improve local mount localion path resolution.
- make open_mutex usage more consistent at process spawn.
- remove mount point directory at umount if we created it.
- remove directory cleanup umount_multi().
- always set ap for mnt_list entries.
- improve handling of missing map entry for expire request.
- don't open code negative update in lookup.
- make negative timeout check consistent.
- add ability to disable negative cache.
- add cifs mount module.
- refactor mount_nfs.c:mount_mount().
- fix a couple of compile warnings.
- fix map source deadlock for recursive submounts.
- fix master_notify_submount() return.
- fix thinko in __mnt_find_submount_by_devid().
- fix setting submount autofs_point in mnts_add_submount().
- improve function mnt_find_submount_by_devid().
- dont auto readmap for hosts map.

Ian
