From: Deke Clinger <dclinger@qualcomm.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Wed, 16 Feb 2011 17:08:37 -0800 (PST)
Message-ID: <alpine.LSU.2.00.1102161700370.29435@tux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=qualcomm.com; i=dclinger@qualcomm.com; q=dns/txt;
	s=qcdkim; t=1297910237; x=1329446237;
	h=x-authentication-warning:date:from:to:subject:message-id:
	user-agent:mime-version:content-type;
	z=X-Authentication-Warning:=20tux.qualcomm.com:=20dclinger
	=20owned=20process=20doing=20-bs|Date:=20Wed,=2016=20Feb
	=202011=2017:08:37=20-0800=20(PST)|From:=20Deke=20Clinger
	=20<dclinger@qualcomm.com>|To:=20autofs@linux.kernel.org
	|Subject:=20RE:=20[autofs]=205.0.5=20non-expiring=20mount
	s|Message-ID:=20<alpine.LSU.2.00.1102161700370.29435@tux.
	qualcomm.com>|User-Agent:=20Alpine=202.00=20(LSU=201167
	=202008-08-23)|MIME-Version:=201.0|Content-Type:=20TEXT/P
	LAIN=3B=20charset=3DUS-ASCII;
	bh=AR4xRI4lElgcPdnL/fe0V3VtDDZTv/bohlwkKncvHpY=;
	b=bUHdOqEqV8tf1Gi7knR4tUMTp7MBU3u0Ux+A2TjX0mBx78ftQlPmm3+5
	tDNaRZ4Y7Uc+VD/CeNx5y/ov7dAbXzcZAZC1ZqB1RtCfy 
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
To: autofs@linux.kernel.org

On Wed Feb 16 12:18:15 UTC 2011 Ian Kent wrote:

> A backtrace generally doesn't do us any good when were trying to find an
> expire problem, the debug log is where we have to start on these.

I've got a debug log from a sled10sp3 machine running the Novell autofs
5.0.5 update. Ian - could I mail you this personally? I'd rather not have
this log with usernames, paths, hostnames, etc. on a public archive.

FWIW, I did do a test with autofs5.0.5 built from source with all the
patches in the patch order list from kernel.org and it demonstrated the
same behavior: a USR1 signal unmounted the direct map entries but not the
indirect. I changed the maps to files, pruned them to a few hundred entries
and converted the indirect entries to direct and re-ran the
test. Configured like this all entries unmounted upon a USR1 signal so I do
believe this has something to do with direct vs indirect mounts. 

Regards,

-Deke
