From: raespi <raespi@estudiantes.uci.cu>
Subject: using autofs ...
Date: Wed, 06 May 2009 15:00:10 -0400
Message-ID: <1241636410.4468.22.camel@bellerophon>
Reply-To: raespi@estudiantes.uci.cu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hi, I posted about a week ago to this list but got no answer ... I'll
try again ...

I'm trying to use configure my autofs configuration in a way that I can
mount all the users directories configured using NFS ...

Here's my original line in my fstab:

x.x.x.x:/home       /home   nfs
defaults,rsize=32768,wsize=32768,intr,noatime,soft      0       0

I would like to configure autofs to do this job for me in case my
network fails ( which happens a lot ), here's what I have:

auto.master:
/  /etc/auto.home --timeout=60

auto.home:
home          -defaults,rsize=32768,wsize=32768,intr,noatime,soft
x.x.x.x:/home

This configuration tries to mount the resource in /home

When I reload my service I try to see the status of the autofs
application but it doesn't show any information.  When I use a different
key in the auto.master and auto.home to mount the resource in for
example: /home/users like so:

auto.master:
/home  /etc/auto.home --timeout=60

auto.home:
users          -defaults,rsize=32768,wsize=32768,intr,noatime,soft
x.x.x.x:/home

It works ... My question is, why can't I use the "/" directory as a key
name?? And how could I configure the two files so I can mount everything
in "/home" ??

Thanks in advance ..

Greetings ...
-- 
#468171
