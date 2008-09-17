From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 09:49:30 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809170943080.12947@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
	<1221669383.3001.35.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221669383.3001.35.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> Hehe, but the ioctl will fail with that many interfaces so you'll still
> have the same problem. You would need to make the buffer larger than 42k
> for this case.

the ioctl soft fails and just returns as much as it can.  the autofs code 
just scans the ones that are returned.  so my patch works for me.  the 
ioctl must have other hard failure options, but a small buffer isn't one 
of them.  the official patch compares the returned length for call n and 
call n+1 and exits once they are the same.
