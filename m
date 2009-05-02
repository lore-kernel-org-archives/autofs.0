From: raespi <raespi@estudiantes.uci.cu>
Subject: how to use keys ...
Date: Fri, 01 May 2009 23:27:31 -0400
Message-ID: <1241234851.12172.5.camel@bellerophon>
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

Hi, i've been trying out the autofs mounter to gain more availability in
my network environment ... I have a number of users created already
under :

/home/.....

/home/teratux  :: For example

I want to be able to automount a resource from NFS in this exact
location.  This is my auto.master:

/home   /etc/auto.home --timeout=10

This is my auto.home:

x          -ro,soft,intr,rsize=32768,wsize=32768,noatime
10.7.22.178:/home

My problem lies where the "x" is.  How do I use an indirect key name in
a way that any request under /home automatically fires up the
automounter?? I already tried:

auto.master:
/   /etc/auto.home --timeout=10

auto.home:
home          -ro,soft,intr,rsize=32768,wsize=32768,noatime
10.7.22.178:/home

With no success.  The /etc/init.d/autofs status script doesn't show
anything going on ... I'm using Debian as you can already imagine, a
2.6.26 standard kernel, and autofs 4.1.4

Can anyone help me??

Thanks ...
-- 
#468171
