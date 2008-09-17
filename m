From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 10:26:10 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809171021540.12947@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
	<1221669383.3001.35.camel@raven.themaw.net>
	<x49od2m7m88.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49od2m7m88.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

> Yep, gather a debug log and include the other pertinent information
> from:
>  http://people.redhat.com/~jmoyer/

well, it's a production box and only seems to show the problem at boot 
time.  from looking at the logs, i think this is the underlying culprit:

Sep 17 09:18:08 hyperion kernel: RPC: Can't bind to reserved port (98).
Sep 17 09:18:08 hyperion kernel: RPC: can't bind to reserved port.
Sep 17 09:18:08 hyperion kernel: RPC: error 5 connecting to server jupiter.spiretech.com
Sep 17 09:18:08 hyperion kernel: RPC: Can't bind to reserved port (98).
Sep 17 09:18:08 hyperion kernel: RPC: can't bind to reserved port.
Sep 17 09:18:08 hyperion kernel: RPC: error 5 connecting to server jupiter.spiretech.com

that is from the client trying to talk to the server.
