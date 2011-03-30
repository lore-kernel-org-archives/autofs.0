From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: [PATCH 0/2] Series for the non-expiring mounts problem
Date: Wed, 30 Mar 2011 13:13:52 -0300
Message-ID: <AANLkTimKbS8A6OW-B-BGiAccAh_71YO8CF92zP0K9TE2@mail.gmail.com>
References: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=Lq4IIrroxlF38Y15lzyl6/a4EwsJRP3TxIEvo5qPaNY=;
	b=GfgjNd3mdVwAxyDJT9ye8Dn1QxYSlycmhFj5LHCYMWw4pLXAqI0br/0xV9ifvlL9rR
	+b3ubOk1pOzMdAbvT69w70m4FkrbQ60Qc6nHug5c96Qmf4KUySZlnAKYg6/wOWKujuBy
	Lz/mIKD+QA4OB/xe9wgJqzqxVNzvbHc6NB0KQ=
In-Reply-To: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

On Wed, Mar 30, 2011 at 2:49 AM, Ian Kent <raven@themaw.net> wrote:
> These two patches should fix the problem you reported where a USR1
> signal fails to trigger an expire. They should also fix the unnecessary
> map reload problem.
>
> Please test these for me.

Ian, thanks for the patches. I just tested them here and confirm that the
problem is resolved. I tested direct and indirect mounts letting them expire
after the default timeout and forcing the expiration with SIGUSR1.

I also confirmed that the "unmountable directories" problem reported in
http://linux.kernel.org/pipermail/autofs/2011-March/006509.html is fixed
as well (the patch I suggested back then is *not* needed).

Thanks,
Leonardo

> ---
>
> Ian Kent (2):
> =A0 =A0 =A0autofs-5.0.5 - fix stale map read
> =A0 =A0 =A0autofs-5.0.5 - fix next task list update
>
>
> =A0CHANGELOG =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0daemon/lookup.c =A0| =A0 =A01 +
> =A0daemon/state.c =A0 | =A0 =A09 +++++----
> =A0include/master.h | =A0 =A01 +
> =A0lib/master.c =A0 =A0 | =A0 37 +++++++++++++++++++++++++------------
> =A05 files changed, 34 insertions(+), 16 deletions(-)
>
> --
> Ian
