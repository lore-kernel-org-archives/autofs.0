Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36B18D658
	for <autofs@vger.kernel.org>; Fri, 22 May 2026 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410479; cv=none; b=GfxTqPjvitLP+2T9mQyUMgW6SoY+DyjWGsLuf2YvM25ae6zw1a+7kZhb7ESuJ9jew6d2aAimq8zsDtn9gG90YeFOthVHaGqc7QrU9w67RhoVj2PHodDsi33ICHHfRcgYM+3lVkFNxWlty4u6QoJcvWeeIWGcE9K1Y/FjT1Jz7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410479; c=relaxed/simple;
	bh=Uv/34cDi72NbYJ0JDeRwgWNUf3BfYS4exIFC6/Hqrcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qXKWQCUF2ILwKMe3PRcCifKvbyGHTCDQGeOb7sRodoL1UvJ238ruwxfpfgcVv+pYBvjjRPe1EJJ8B3r6b5KEDDFQY0k6/vmye2yaCN8Iwe3NwfDIkZLCG3aHT49h8r+EK7O4a4KgzQqoE9dQCK3HFwKKq09VGE0eE4LJnGpp6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vs9Hy2mJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs9Hy2mJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGk2CQ374056;
	Fri, 22 May 2026 00:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X+KLIE5p2l6CJ0EDkzJsMXgE
	LKUO1V1drRA6ZZYyaAU=; b=Vs9Hy2mJ7ksaX/qtUC45z1vnjYHA55gMyutCTjUg
	f5p8eonUdHIJ6+wqbEBNDbypNFxP07x29QaqhjaieDVMxogHIyEtcMHEmCn+3FxP
	IPu854Z6XnjH71ZUsqMvxWfKspPMpHY6QFmtITeKPKJYF2v9iX7vJLFdW5z+D9SX
	cS+IBlNAFlrW7Q6X38QwsBJ4W1pyfECGCyOFuAs3pd+s5FaNJJ6MVcgIjmbsGvJH
	CaWYxSqZFHECLf71K8e9AK/emAyslb+6XnyWyOGhaBP+Y6FCqEyzhsjb1+yj1Qn9
	KB2wUDnThp0d8CliZrdhOB+6HAKXkx5e4e1i6UhQyRP16Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9vhbmg2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 00:41:12 +0000 (GMT)
Received: from eslab05.qualcomm.com (eslab05.qualcomm.com [10.63.68.138])
	by NASANPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M0fAXX007302;
	Fri, 22 May 2026 00:41:10 GMT
Received: by eslab05.qualcomm.com (Postfix, from userid 21817)
	id AF4831C036; Thu, 21 May 2026 17:41:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by eslab05.qualcomm.com (Postfix) with ESMTP id A78F61C035;
	Thu, 21 May 2026 17:41:10 -0700 (PDT)
Date: Thu, 21 May 2026 17:41:10 -0700 (PDT)
From: Deke Clinger <dclinger@qualcomm.com>
To: Ian Kent <raven@themaw.net>
cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, autofs@vger.kernel.org,
        lidong.zhong@suse.com
Subject: Re: Unable to set log priority for all direct mounts
In-Reply-To: <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
Message-ID: <a1be8d50-dddb-2297-1e7f-512c37ca9214@qualcomm.com>
References: <agYonWw9_WVrWyub@zuko.lan> <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAwNCBTYWx0ZWRfX+pS2fqYzymi9
 1KAgI6Mbc6xzhd4shLqwI7n4Bq+iXvRAwTL/XJV+NcCQy6x6pp6HS6SOhjyboIWaAnkY387YpHM
 kprz2J2gF5DfS40zu7IcjH8KnLgpdlWd5aPkixOMP02lfPzTyWMItk6Jb3nq79pwKMw4rGbsA+3
 KKUm+9V+4NH5q4nlCHiqNcbfv06W6qzsiwHQZXYoTjMNT/0vn8o6QHoxVRq3xJVisE/l/NmX8cQ
 LGyM9z4lqv1vrDgd8EV4P0SjbfvcTqBWZ3fP6WantpiAI54JQbp/7DdOz7tAK9y7O6PeFWBvhJP
 K9dbFZTvDsJXTXctl7OjbX7Mg6ovprPoOg0/AEJMtnP4bvWusVTDvqDl/8wwHFsV5spUXouFlRF
 LEE6uKHnDi1o2Gumo46uIjFBZ2JVQowhkfzIWDQsfHwUSPKPeDEer1S+UwEyOZKCkKDyfX/Y2N3
 bmgmjlFswWbEaKjUIKg==
X-Authority-Analysis: v=2.4 cv=GYAnWwXL c=1 sm=1 tr=0 ts=6a0fa628 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=jUFqNg-nAAAA:8
 a=ue1zp5Xs7JeFpSViqrAA:9 a=CjuIK1q_8ugA:10 a=-tElvS_Zar9K8zhlwiSp:22
X-Proofpoint-GUID: 0A41-fkOimmfJydq0IqKEVKmBBCKLAeN
X-Proofpoint-ORIG-GUID: 0A41-fkOimmfJydq0IqKEVKmBBCKLAeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220004

Hi Ian,

Thanks for fixing this, it was my request originally. It is super useful to be able to change the log level for the whole direct map with one command when that map is tens of thousands of entries long.

Regards,

-Deke

On Mon, 18 May 2026, Ian Kent wrote:

> WARNING: This email originated from outside of Qualcomm. Please be wary of any
> links or attachments, and do not enable macros.
> 
> On 15/5/26 04:01, Goldwyn Rodrigues wrote:
> > Hello,
> >
> > Since the work to have a single FIFO file for setting log priority
> > (16ea4156 ("autofs-5.1.8 - switch to application wide command pipe"), to
> > be more precise 16ea4156 (autofs-5.1.8 - switch to application wide
> > command pipe), automount has lost the ability to set the log priority of
> > all direct mounts using the path "/-".
> >
> >
> > # sudo automount -l info /-
> > Could not find device id for mount /-
> >
> > This is because automount attempts to mount and get verifies the real
> > path which is non-existent in case of direct mounts "/-".
> >
> > In the automount program, the log priority is set pretty early and much
> > before the master map is setup. So we cannot check on the autofs dev
> > either.
> >
> > What would be the best way to solve this? Should we just document it
> > as a feature loss?
> >
> 
> Haven't actually tested this but it should work to fix the log priority
> 
> for /-.
> 
> Could you give it a try please.
> 
> 
> autofs-5.1.9 - fix handling of direct mount path in command handler
> 
> From: Ian Kent <raven@themaw.net>
> 
> Commit 16ea4156471e ("autofs-5.1.8 - switch to application wide command
> pipe") broke the ability to set the log priority from the command line
> for all direct mounts.
> 
> As Goldwyn Rodrigues points out the autofs_point structure for direct
> mounts doesn't have a real mount associated with it so it needs special
> handling which was ommitted in commit 16ea4156471e.
> 
> Fixes: 16ea4156471e ("autofs-5.1.8 - switch to application wide command pipe")
> Reported-By: Goldwyn Rodrigues <rgoldwyn@suse.de>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  CHANGELOG          |    1 +
>  daemon/automount.c |   17 +++++++++++++++--
>  daemon/master.c    |   11 +++++++++++
>  include/master.h   |    3 ++-
>  4 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/CHANGELOG b/CHANGELOG
> index d6d594e9e..0fc529f32 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -89,6 +89,7 @@
>  - do_reconnect() expiry check of dclist BEFORE lookup using it.
>  - fix mailing list subscription address.
>  - fix table_lookup_ino() fd reference.
> +- fix handling of direct mount path in command handler.
> 
>  02/11/2023 autofs-5.1.9
>  - fix kernel mount status notification.
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 517764119..a01d176ae 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1487,7 +1487,13 @@ static void handle_cmd_pipe_fifo_message(int fd)
>                return;
>        }
> 
> -       ap = master_find_mapent_by_devid(devid);
> +       /* There's no "real" devid for the top level direct mount
> +        * container so we use -1.
> +        */
> +       if (devid == -1)
> +               ap = master_find_mapent_by_path("/-");
> +       else
> +               ap = master_find_mapent_by_devid(devid);
>        if (!ap) {
>                error(LOGOPT_ANY, "can't locate autofs_point for device id
>                %ld.", devid);
>                return;
> @@ -1548,7 +1554,14 @@ static int set_log_priority(const char *path, int
> priority)
>        if (!ops) {
>                fprintf(stderr, "Could not get ioctl ops\n");
>                return -1;
> -       } else {
> +       }
> +
> +       /* There's no "real" devid for the top level direct mount
> +        * container so we use -1.
> +        */
> +       if (!strcmp(path, "/-"))
> +               devid = -1;
> +       else {
>                ret = ops->mount_device(LOGOPT_ANY, path, 0, &devid);
>                if (ret == -1 || ret == 0) {
>                        fprintf(stderr,
> diff --git a/daemon/master.c b/daemon/master.c
> index d85dd8975..8b7450e73 100644
> --- a/daemon/master.c
> +++ b/daemon/master.c
> @@ -711,6 +711,17 @@ struct master_mapent *master_find_mapent(const char
> *path)
>        return NULL;
>  }
> 
> +struct autofs_point *master_find_mapent_by_path(const char *path)
> +{
> +       struct autofs_point *ap = NULL;
> +       struct master_mapent *entry;
> +
> +       entry = master_find_mapent(path);
> +       if (entry)
> +               ap = entry->ap;
> +       return ap;
> +}
> +
>  struct autofs_point *master_find_mapent_by_devid(dev_t devid)
>  {
>        struct master *master = master_list;
> diff --git a/include/master.h b/include/master.h
> index 71610611f..3ca7ad8d6 100644
> --- a/include/master.h
> +++ b/include/master.h
> @@ -105,7 +105,8 @@ void master_source_readlock(struct master_mapent *);
>  void master_source_unlock(struct master_mapent *);
>  void master_source_lock_cleanup(void *);
>  struct master_mapent *master_find_mapent(const char *);
> -struct autofs_point *master_find_mapent_by_devid(dev_t devid);
> +struct autofs_point *master_find_mapent_by_path(const char *);
> +struct autofs_point *master_find_mapent_by_devid(dev_t);
>  struct master_mapent *master_new_mapent(const char *, time_t);
>  void master_add_mapent(struct master_mapent *);
>  void master_remove_mapent(struct master_mapent *);
> 
> 
> 
> 
