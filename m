Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2111.outbound.protection.outlook.com [40.107.237.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FA4D8BB
	for <autofs@vger.kernel.org>; Tue, 11 Jun 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131214; cv=fail; b=IlMQhp7aI4fSv5/c+2gPDG9RhiShN+I0F1K6rs6Iz/AA8NQ7iK4ea809kUIDRjjvY4EhaIxmnjI89UBbyb8o0nRehZjy5epdDj0W6e+o7ZrjQ2M4EhtQIxphibdUSK8G8PbCUJtYLsxYqgRBz8OeMIz0JiepqrBumW5ml/IOgio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131214; c=relaxed/simple;
	bh=sIT725SPirqLIjV6UeNvq6wWfACemN8itg3Sh8luJko=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Po9r4CxoROwOYZyYo/z/eaYRcSS83MqbOPQ8x/hYBP1Mhq6Pk1Thgb6Nr1jQuQfahNpH+QianPthd+kT+EamvH3QbuKMrur4482QrFw1hKr+j9iq7lKXwm/wYKipaBQ/g75MBRz3R1pCoV45gZmhwqdLofvo5QerAKpcyIu5Ai8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alleninstitute.org; spf=pass smtp.mailfrom=alleninstitute.org; dkim=pass (1024-bit key) header.d=AllenInstitute.onmicrosoft.com header.i=@AllenInstitute.onmicrosoft.com header.b=RlZDlsuH; arc=fail smtp.client-ip=40.107.237.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alleninstitute.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alleninstitute.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=AllenInstitute.onmicrosoft.com header.i=@AllenInstitute.onmicrosoft.com header.b="RlZDlsuH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc3a7wvaD53WvWjIuRPeuD0D8bWMbzwIVXhehUmL9sh9CmapiC5fd+9q7z6jR4YQ2fPwbk0whT/Paryf1BLBSI/6NR+/6uEypEyH9hEWby/Rqn55qd4+SWFg8OxP9YkktcgFV+KWnrCxqVXCFU/1TNAC6WH+OnIV6ipYiUEl+bDSyCYsks11yYVvnFr8O0jYOSl+NCye5yRpkChzWSIbhKQtXd0O/4fb2eCC34AAXGpZ0s2wYdDZb/MMWRvwfnrjzQReW23rTat5+pF1Hr15KfO3rGqiKAgkHspFQ8jh8y9b7GVloMDLziAbGfNvURo5xdScicBAukBshEVaaw5Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6MJKgo8g63flmuoRppfk8sEm1P7UrdHC1VRXkkuJrA=;
 b=GN4u4H1FO4kgq985JsqU3PEIuA8h9cZ+oOpRsP3fxXrtIF23l4XGfahQFxLxcJhppqtcQklHX3CE2zYCy9pFbrmElnR+3tp2s6A4rfKbv/t4nkji0TfNFffAK6YTJCj0WUvCSBbI05VxRc4LtekCnzG5/32EUfQ+Um7RQSc3ZH2o8VRJwuP2SQpcRk6wzidl9or3LP+JOTihmH/4twYP3sfybEQaYg/FcOYB17HT/OjOmltkjqQ1TfunG1w8+MHqSpVHhKgPDGbC6mB30q3M2HTNtAQliREljcq/JczdkDepM9jln2pPGmwR3XpMbiWU1lriOsZBuxIboyP/fL1JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alleninstitute.org; dmarc=pass action=none
 header.from=alleninstitute.org; dkim=pass header.d=alleninstitute.org;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=AllenInstitute.onmicrosoft.com; s=selector2-AllenInstitute-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6MJKgo8g63flmuoRppfk8sEm1P7UrdHC1VRXkkuJrA=;
 b=RlZDlsuHsGMsWk1WmnlvHsWq0uYUsJC342T4/ZJUaTxC8DH9O1a8DLYxQW7lEgdytysMznUtxzww1YLiFmFz+VzXQHiu+QbxcYiFaCgsspFjrH3yQulDyJVfOB52b9NXdqmr+LXgvgQGdcjC5/QYQfb+/Q8tYMu93kG9hh638ac=
Received: from PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 18:40:08 +0000
Received: from PH7PR12MB5686.namprd12.prod.outlook.com
 ([fe80::2c1d:4b4d:9fa4:d758]) by PH7PR12MB5686.namprd12.prod.outlook.com
 ([fe80::2c1d:4b4d:9fa4:d758%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:40:07 +0000
From: Nathaniel Middleton <nathanielm@alleninstitute.org>
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>
Subject: autofs mounts expiring unexpectedly and unable to remount after
 disappearing
Thread-Topic: autofs mounts expiring unexpectedly and unable to remount after
 disappearing
Thread-Index: Adq8KgJWZ/RCeKWvS06qf0qvLa6Qyg==
Date: Tue, 11 Jun 2024 18:40:07 +0000
Message-ID:
 <PH7PR12MB5686C29F1D980041ADA33BD3ACC72@PH7PR12MB5686.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alleninstitute.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5686:EE_|SN7PR12MB6744:EE_
x-ms-office365-filtering-correlation-id: e5f24540-5e2f-44de-0da8-08dc8a45eadd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c0ZwNbLba+ZXPk8TPhLlKFuqn6OVKRFJplPwN3N26N7iZlBJhkH/NLtbwT1M?=
 =?us-ascii?Q?1uh9G9tqUu0r38+wMd9+kQ4bC1eJbxnKZMRaWF1RzZB21kZzp4owWIwIjyn5?=
 =?us-ascii?Q?IwNuhqCWv7F1fyXO1knhB+BgeBZSNMzqYyAKGrnD6b4EpsdR3oemQcR+T6Ho?=
 =?us-ascii?Q?NGKL5/tRxHyLe95YN5wFThtV1mKao5A4jxZbxNM0A/WGGsoYhDebDkUc3VzE?=
 =?us-ascii?Q?duHlVRRbrPX5/Af3uCEnpyZTy2LDteK0LyWVJAcJA2L+RDRyqZM8OSABGKMY?=
 =?us-ascii?Q?EevuVNvwnyrLcl/8rl4ywJplG0vci4/+NtNIXqK5fZruekaQnw2Bp0YKtpVQ?=
 =?us-ascii?Q?z50g4HBeN3Svfx2HrML/qeH0WewHWgM8zdfW+D5LG+Gj/kyzBBFGKqixy3W5?=
 =?us-ascii?Q?1oiOrROuQNw/wMSdEGKojv7n1sSlSn9DIwAENG+125OpOb3LnTS03abL9VP6?=
 =?us-ascii?Q?WTlP9wUdFzR+Br085nTe7jeiy4cuDuORa2wi/mnaCczm6pm11nDVMqXfCupF?=
 =?us-ascii?Q?6YKDgnRrb6ajYO0pil9j1EPbn1nCuWQ+SUPvn6KdITGihKhNfHGrEYwBxgOl?=
 =?us-ascii?Q?cNwQBqxvI8cT/iFp6Xww1PSEnVsQiUxXS7l0BwQ5v98lG3nDe8ZSb6b8lwiK?=
 =?us-ascii?Q?uxeRk4dtUzLn4qe+Trf8C8vU+1qU/x1fJd0OC29aRs8arfCM94kDXAfwn5RA?=
 =?us-ascii?Q?ZTazq0F1YOfrp5fkRxaTWPL4pHp6eA/++uc7/J8l/hvWod+ULkAnlVL5kyB+?=
 =?us-ascii?Q?WtHV+Q6MO8R4HtwgaSDnMqthWuQGl7vKLQOrLZ9/amhnQ+HlxfmZNlb3Efe0?=
 =?us-ascii?Q?SJ/UXb9ltujx6rZAilbavmeinUoxMkrdrWArmDHd/vCUrCPVnrkpXHBs1qEa?=
 =?us-ascii?Q?rvf7EjF2CPsjaJt9Xnf3SH+EuuZ+ApPJ2nG1s0CFao43VRdrppJfdE5HYxJL?=
 =?us-ascii?Q?pMU81rRr7ejgA+b2zii9PdBiRGM/qXTTP9uFMgkeWLOBoSLdir/Fc15hm3jG?=
 =?us-ascii?Q?YZjtuow9SStomPAo/AwlV4ykw9xnuKUfpWSRXS8/MCTERuGg4hNVfsxInT0K?=
 =?us-ascii?Q?9YxZuXrOrtJOIpGz3yznZZxwhyF0wXfZKHFH0zwqz+3+ur9kjE70XmP40tHG?=
 =?us-ascii?Q?2jNVbVKUZTIubxNb8B+ZJgTfwwYEO2vsClcmhpyizp2tbzaNBto75ewTz4id?=
 =?us-ascii?Q?b04dIegiq6VMEJsLc/hMNMy2N2T7Mfd94WRco5JPiTItyoUV8MqbdzUvP7RY?=
 =?us-ascii?Q?syia5lCPQM9ruMi8m6wiiDoBRkgKe42/h/agoLDFgCvf9w9kiFfpwV5SN/nc?=
 =?us-ascii?Q?sNUbbNT5nerfkXK0dad0GDJGWVsNvzODWWzUQHNJ96U9sqEZLaJ4YXeAY2Ff?=
 =?us-ascii?Q?V+83nOE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5686.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jGUEJj6h4C693Reqz2w4SvL+u1QiEPo9clgr6NmyYQ+9OOu7HeXK2ScR+O6K?=
 =?us-ascii?Q?Gj59TjkNmRHoDzbS8v/219Hys2U/1hRAr6JDh6m9HtSmpZBkRkGrHXlKc2Zc?=
 =?us-ascii?Q?50/7rqQZAGwq+LUrUKsXlxJ6HAdoQA1Bht9DU8oGvajT2vWo9KACCkVTXK84?=
 =?us-ascii?Q?4f2XuxYP3KcxrXL/temqyl1oeoN3q+aM/h8d1qT/j1vXumPvajtROmdG31F7?=
 =?us-ascii?Q?kBuB9PJ3X3MLyPNxkkYLbf9gGbvlSLQAL4m+YJCWmEVdJ16eCWcWnrf73lSf?=
 =?us-ascii?Q?jG4Ln8p7/tnRPHSQ1M2tDjN11a7JxoKKzUDqkPd3aL41PfXQQ13C+xDnT5gE?=
 =?us-ascii?Q?0q+29vCHB3D+Z2ylryvNUL2cvxupgO8jr0gyj3JdFY4NfvtRD2C8a3OGJf31?=
 =?us-ascii?Q?KzR/4pT43Sr3GKbhM8elyggd1XcvCvt8QcIiQvRkKCTBt9d7YF3KyP/z6D/A?=
 =?us-ascii?Q?11G6JS3cLJI/HL87e5TsaNg7Nk7MlPgGnMf2d0nqu5+bmGlrBWuN1qoQZ1NP?=
 =?us-ascii?Q?Qhk9HQMM3H8yy1JabMmi7Gt88R4KeZo//IitAdFEEiauxWOCRqZBeroyOYA8?=
 =?us-ascii?Q?hpaxUsyrQLOdmZoOBgEUJhv64wGJnjjQzOxoXY+sZQtEvrk1iNDb1OERAyYz?=
 =?us-ascii?Q?dtUELQFceavzt1tHbph58uOCCTMgKhw3rlslTlk2FOhwPF1FZ+TxpfVvbRAN?=
 =?us-ascii?Q?Znw/xbWh3aXSLtnW9v1lCgYF+iA9mo56D2wKQJIkQKAj8eKtdibEPEx3LNuF?=
 =?us-ascii?Q?qh/G1Makm7pW2xLb31XYzyPORPDoedQXbuU7S+7xfVlV2NC0Aff6npg1dF4K?=
 =?us-ascii?Q?9c8EX0QBGgDM1PpOuuuG1vC+vI8RbCt+14Lgk37syU7QAXBDo4l182luvAe0?=
 =?us-ascii?Q?hRMfk7Eh7x0COX5KrNTHUVtaGpWkwoH6PtzK3chxNPoJAxNgpgFb3R7AfnOF?=
 =?us-ascii?Q?HMf2OC5egcBBZxKiVtA4Ad6mEuOkT96K2SInjfmryY2Vuar0RB0/dnEvepmK?=
 =?us-ascii?Q?5prOvl+8CvTCzspJgr7NXJV99qtodoYIQO82Vr7eMienNTbDKh78m1URXgxd?=
 =?us-ascii?Q?HCW5uzpZEAuEXAr5TMqepcCEwt43rNSJFGzG2BVTAdMBb9C4CiKGuYQqca9p?=
 =?us-ascii?Q?suK4D0E4F0Jf9Ljtpfqp2r0V00Pnbgx1nNhvxobpmt4dnSUBF/gmVS1HTqcC?=
 =?us-ascii?Q?Men/k65OiQtQ+t1Ag6llztA5qdkjepKfKXJ0orUPOuTrGCpdLkHk1kGHWR4l?=
 =?us-ascii?Q?ACtT3p/TQBihzja+O4y+iJAdnpF/X0g1MoF6B6RSorD5xtYMyh38FlQZxlus?=
 =?us-ascii?Q?rQBJWVry0xvuIiR0Sx/smk5nKb6/YzGgFDSAFjIsd9ZVxKDwJz0xhXNDrCxa?=
 =?us-ascii?Q?jAnyaCUu6FakEFHo0xIXrxo90Pg+ohTisV3IfJHXi0gmenN6fRLEv84S4/IC?=
 =?us-ascii?Q?mulrNFbh8lpIus2F6Pb5Eh2aVuz+56/x0y5NZWMyC+8Y6kMl93fFcu6GRMmY?=
 =?us-ascii?Q?rCnb/8ZAXFZVJ8yMN42GGKXp3A1zd/s3jip8tdH4guFhiB1r6Oj2EiEgm8qB?=
 =?us-ascii?Q?RGW/p1j0Y94TKzFREs1aUwnrqrbn09x/98ucG5WWo10Wz2vwXGN/fRls4fUJ?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alleninstitute.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5686.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f24540-5e2f-44de-0da8-08dc8a45eadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 18:40:07.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 32669cd6-737f-4b39-8bdd-d6951120d3fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAYjJNZozWHTRRCio0J4wO4C6My9+TKEzYEByA88kKp84SwdpZNMJfFAhEWcgH7+MbNqiYnScFa62IId7l5Twi/UcKkKaXF/OId4jZ3Qj0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

Summary:=20
We define a /mount/path/pathcontd/mountpoint tree in autofs, have historica=
lly --ghosted the paths, but have recently attempted to set the offset moun=
ts as browse-able.=20
Our configuration works great... at first. Once the timeout hits (I set thi=
s to 10s for debugging... but normally have it set to 300s), the autofs (ty=
pe) mount points start expiring. Once this expiration starts, the offset mo=
unts disappear (often leaving one mount point remaining that is broken). Th=
e disappeared mount points are unable to be re-mounted. This has hit us at =
semi-regular intervals on Centos 7 , but Rocky 8 servers are highly repro-a=
ble. This could be due to the lack of activity on the new systems though.

Config:=20
distro Name: Rocky Linux 8.8 (Green Obsidian)=20
autofs-5.1.4-102.el8_8.2=20
NFS4.{0..2}(though... the nfs mounts are not being invoked when this issue =
happens.)
Autofs configs:
Auto.master:
/allen/programs/celltypes  /etc/auto.programs_celltypes tcp hard intr timeo=
=3D600 retrans=3D2 async --ghost

auto.programs_celltypes(snipping out similar lines to conserve space):
production -fstype=3Dnfs4 /incoming         aidc-isi1-prd:/ifs/incoming/aib=
s/celltypes \
                        /0378             aidc-isi1-prd:/ifs/programs/cellt=
ypes/production/0378  \
                        /brainstim        aidc-isi1-prd:/ifs/programs/cellt=
ypes/production/brainstim  \
                        /conn             aidc-isi1-prd:/ifs/programs/cellt=
ypes/production/conn =20
workgroups  /0285             aidc-isi1-prd:/ifs/programs/celltypes/workgro=
ups/0285 \
                       /0378             aidc-isi1-prd:/ifs/programs/cellty=
pes/workgroups/0378


We have a couple similar mounts in a similar mount point to "/allen/program=
s/<different name>/<mount>" if it makes a difference there.

What this looks like:=20

Temporarily working:
ls /allen/programs/celltypes/production
incoming  0378  brainstim conn

Broken:
ls /allen/programs/celltypes/production
0378

Statting of this path results in a wedged terminal, the autofs mount still =
is showing however:
/etc/auto.programs_celltypes on /allen/programs/celltypes/workgroups/0378 t=
ype autofs (rw,relatime,fd=3D105,pgrp=3D4816,timeout=3D0,minproto=3D5,maxpr=
oto=3D5,offset,pipe_ino=3D83070
I claim that the autofs mounts should not be expiring at all... and that I =
want mounted NFS sessions to umount after timeout. Stopping autofs results =
in a loop of trying to umount the remaining autofs shares until it hits a t=
imeout and gets killed.
The remaining autofs mounts return busy when umount -a -t autofs (or the se=
ssion locks up). lsof and fuser show 0 processes using the mount point.
4 D root        7929    7805  0  80   0 -  6329 autofs 09:37 pts/2    00:00=
:00 umount -a -t autofs

If left alone, the state seems to get continually worse as more autofs moun=
ts expire. Example being on the /allen/programs/celltypes/production path (=
not a NFS mount point)
ls ing:
/allen/programs/celltypes/production:
^C

Logs:
Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/pr=
oduction
Jun  5 10:11:49 n238 automount[19033]: expiring path /allen/programs/cellty=
pes/production
Jun  5 10:11:49 n238 automount[19033]: umount_multi: path /allen/programs/c=
elltypes/production incl 1
Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/pr=
oduction
Jun  5 10:11:49 n238 automount[19033]: expiring path /allen/programs/cellty=
pes/production
Jun  5 10:11:49 n238 automount[19033]: umount_multi: path /allen/programs/c=
elltypes/production incl 1
Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/pr=
oduction
Jun  5 10:21:57 n238 automount[25053]: expire_proc_indirect: expire /allen/=
programs/celltypes/production
Jun  5 10:24:27 n238 automount[25053]: expire_proc_indirect: expire /allen/=
programs/celltypes/production
Jun  5 10:26:57 n238 automount[25053]: expiring path /allen/programs/cellty=
pes/production
Jun  5 10:26:57 n238 automount[25053]: umount_multi: path /allen/programs/c=
elltypes/production incl 1
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/0378
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/0378
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/brainstim
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/brainstim
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/conn
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/conn
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/ctyconn
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/ctyconn
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/general
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/general
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/histformfish
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/histformfish
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/humancelltypes
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/humancelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/incoming
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/incoming
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/mfish
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/mfish
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/mfishhisthumanatlas
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/mfishhisthumanatlas
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/mousecelltypes
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/mousecelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/mousegenetictools
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/mousegenetictools
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/nhpcelltypes
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/nhpcelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/synapticphys
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/synapticphys
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/whbi
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/whbi
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount of=
fset /allen/programs/celltypes/production/wijem
Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/program=
s/celltypes/production/wijem
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/brainstim
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/0378
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/humancelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/histformfish
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/incoming
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/mfishhisthumanatlas
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/mousegenetictools
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/mousecelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/synapticphys
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/nhpcelltypes
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/wijem
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/whbi
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/mfish
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/general
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/ctyconn
Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: dele=
ting offset key /allen/programs/celltypes/production/conn
Jun  5 10:26:57 n238 automount[25053]: expired /allen/programs/celltypes/pr=
oduction
Jun  5 10:26:58 n238 automount[25053]: expire_proc_indirect: expire /allen/=
programs/celltypes/production

What I have tried:=20
I was originally distracted by the idea that this was a fileserver issue...=
 testing different versions of NFS etc. But after seeing 0 nfs mounts happe=
ning... I am more convinced that this is a bug in my config, or autofs.=20
The variations of --ghost vs. browse-able have yielded no differences here.=
 The same bug repros on Centos7.9 with an earlier version of autofs.=20
Setting timeout to 0 (I believe this disables timeout) and this behavior st=
ill occurs


