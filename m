From: "Rigler, Stephen C." <srigler@marathonoil.com>
Subject: RE: basic question on "key"
Date: Tue, 5 Oct 2004 11:35:28 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE71015C5981@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Does this work (you'd need to use the modern autofs)?

** auto.master:
/home	/etc/autofs/auto.home

** /etc/autofs/auto.home:
milly	-rw	myhost:/home/milly
es -rw /Data -rw myhost:/home/es/Data

-Steve

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of es
Sent: Tuesday, October 05, 2004 11:19 AM
To: autofs@linux.kernel.org
Subject: [autofs] basic question on "key"

Hello there, I'm using autofs since a while and works very well.
Now I'd like to mount /home/milly and /home/es/Data from an NFS export. 
This means I cannot simply have /home in auto.master otherwise /home/es 
became inaccesible.
********* auto.master file
/home/milly  /etc/autofs/auto.home.milly
/home/es  /etc/autofs/auto.home.es
********* auto.home.milly
./              -fstype=nfs,rw          myhost:/home/milly

It seems I can't use ./ as key nor I can have /home/es in auto.master 
and have Data as key in auto.home.es because it will mount /home/es 
hidding the content of /home/es.

I have read trought the docs but can't find an example of this basic 
usage scenario.
TIA
Eli

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
