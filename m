From: Lukas Kolbe <lkolbe@techfak.uni-bielefeld.de>
Subject: using both nfs3 and nfs4 in a single mount map
Date: Fri, 27 Jul 2007 17:09:00 +0200
Message-ID: <1185548940.22250.34.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

Hi!

Is it possible to us nfs4 and as a fallback nfs3 in a single mount map?

We have /homes coming from many different servers, the older ones only
speak v3 and the newer ones would love to speak v4 as we would.
Currently, auto.master looks like this:

/homes  yp:auto_homes	-nosuid,grpid,nobrowse,-fstype=nfs4,proto=tcp,port=2049

This of course only works for the nfs4-capable fileservers. Is there any
way to also get the old fileservers into this game again?
Using only nfsv3 is no option unfortunately; as is converting all to
nfs4 at once :(

-- 
Lukas
