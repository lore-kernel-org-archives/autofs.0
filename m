Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173E32C71
	for <autofs@vger.kernel.org>; Wed,  8 Nov 2023 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJLC0X2O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50131BEF
	for <autofs@vger.kernel.org>; Wed,  8 Nov 2023 09:49:14 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Gufrc031141
	for <autofs@vger.kernel.org>; Wed, 8 Nov 2023 17:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ASQrDy8y9+bWZ2880ccNgKRtSGk8MZxiAltUq2AzKN0=;
 b=BJLC0X2OBff+OX3OKexk+b8Pcz3dNxr13qLvDThxM6FFJXfZUkjpbtHi8Lzwb8oII6wX
 qhovI6Vt/Rpt0Ft27E3TQPkFLxkM1updYGG2ZRwFjzoXqL++kYyEdwJkK8r3KcC4VlXX
 88aHMQiJapmhCddcL+qHq1f0r7FmBbt4EjjFflTKyDLubWSIYZf1jZbMY3vDSrftSZTA
 u0aiYsqHF7mAYqzB5k/kI4GVktW0/1aCY7RzJn+F9SYnyz4cx9INzVDCXgrjGEqyErUg
 bKEv7ZkEPRmAnRa1kWjdSA/Ok78ZwXJgNcN806oRccqxkoyieRJtJ9elI/6YEVz1a+lj YQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7wt2ab90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <autofs@vger.kernel.org>; Wed, 08 Nov 2023 17:49:13 +0000
Received: from sunapee.qualcomm.com (sunapee.qualcomm.com [10.62.117.90])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A8HnC5L023793
	for <autofs@vger.kernel.org>; Wed, 8 Nov 2023 17:49:12 GMT
Received: by sunapee.qualcomm.com (Postfix, from userid 32836)
	id 7F30D416B; Wed,  8 Nov 2023 09:49:12 -0800 (PST)
Date: Wed, 8 Nov 2023 09:49:12 -0800
From: Mike Marion <mmarion@qualcomm.com>
To: autofs@vger.kernel.org
Subject: Re: Skip autofs unmount on daemon exit
Message-ID: <20231108174912.GI5574@qualcomm.com>
References: <CADVsYmhjjKYUCHGWmzeTHXuQNAiR6ELbGzyy+m30ar+yaYLBzQ@mail.gmail.com>
 <aeb5af36-4686-9d69-22fd-89adf5fd2c80@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb5af36-4686-9d69-22fd-89adf5fd2c80@themaw.net>
X-Operating-System: Linux 5.14.21-150400.24.69-default x86_64
X-Distribution: SUSE Linux Enterprise Server 15 (x86_64) 15.4
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZE65B3rL8mQsDHy-a2JRShvTPfOvw_7c
X-Proofpoint-GUID: ZE65B3rL8mQsDHy-a2JRShvTPfOvw_7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_06,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080147

On Tue, Nov 07, 2023 at 10:15:05AM +0800, Ian Kent wrote:

> On 7/11/23 01:05, Robert Vasek wrote:
> > Dear autofs community,
> >
> > We run an instance of the automount daemon inside a container (a part
> > of a storage plugin in Kubernetes). The autofs mount root is shared
> > between different containers, and must survive restarting the daemon.
> 
> That sounds unusual, please tell me more about how this works?
> 
> My thought was always that there are two ways one would use autofs in
> a container.
> 
> One is mapping an indirect mount root (from the init mount namespace)
> as a volume into the container thereby using the daemon present in the init
> namespace. Yes, this has had an expire problem for a long time but that will
> change (soon I hope).
> 
> The second way is to run an instance of the daemon completely independently
> within the container.
> 
> But this sounds like a combination of both of these which is something I
> hadn't considered.

FYI, as a third option/way, one thing we do is that we bind the root of
direct automount maps into containers (though we're using singularity)
and the automount bits continue to work just fine inside and out of said
containers.  We have not noticed any big issues with expirations not
happening, at least that we can contribute specifically to the container
use in these cases.

Note that singularity seems to understand autofs mount points though,
and if started with debug it walks and loads the direct map into its
internal /proc/mounts, which is probably why it works so well.  Now that
I think of it, I have no idea if it continues to work with any paths
added after the container starts though since it wouldn't have been
there when starting and might not be seen as a trigger.

-- 
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com
