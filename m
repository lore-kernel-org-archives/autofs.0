From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in	ldap
	automatically
Date: Sat, 26 Aug 2006 11:20:24 +0800
Message-ID: <1156562424.3023.82.camel@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
	<44EEF1E6.7040008@inria.fr>
	<1156511928.30971.12.camel@raven.themaw.net>
	<1156512652.30971.19.camel@raven.themaw.net>
	<44EF1747.5010103@inria.fr> <E1GGe66-00006L-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGe66-00006L-00@mta2.cl.cam.ac.uk>
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
To: Piete.Brooks--autofs@cl.cam.ac.uk
Cc: autofs@linux.kernel.org

On Fri, 2006-08-25 at 16:21 +0100, Piete.Brooks--autofs@cl.cam.ac.uk
wrote:
> I've just had my wrist slapped for suggesting doing three queries for the 
> three "common" schemas, so changing from a one level search (which should be 

I didn't mean to be nasty.
It's just that it seems like every time I do something in response to
requests someone else then wants the opposite.

Actually, using the multiple schema we were seeing up to "nine" queries
per lookup during a mount failure situation which is really bad for a
busy server. It's now one or two so it's much better.

Ian
