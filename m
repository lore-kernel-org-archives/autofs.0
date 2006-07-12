From: "Gomez, Daniel" <dgomez@tigr.ORG>
Subject: Re: bug in linux mount? (says NetApp)
Date: Tue, 11 Jul 2006 22:13:44 -0400
Message-ID: <7F0AA25C9B1706448E8B73DFDD109B31028E5B13@EXCHANGE.TIGR.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <nfs-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
Sender: nfs-bounces@lists.sourceforge.net
Errors-To: nfs-bounces@lists.sourceforge.net
To: autofs@linux.kernel.org, nfs@lists.sourceforge.net

Hello,

>> * What do you think proper options for NFS auto/mounts would be for
>> extremely busy centralized NFS filers?
>
>Something like
>
>mount -t nfs -ohard,timeo=600,retrans=2,rsize=32768,wsize=32768,tcp
foo:/ /bar
>
>should be a fairly safe bet. You might want to add the 'intr' flag too,
depending on how you feel about the behaviour w.r.t. pressing ^C.


We use the following setup with good results and without loss of
functionality (assuminig linux defaults [eg, 'hard','rw', etc]):

For read-only filesystem:
	
ro,rsize=32768,wsize=32768,timeo=600,actimeo=600,intr,tcp,nfsvers=3

For read-write:
	rsize=32768,wsize=32768,timeo=600,actimeo=120,intr,tcp,nfsvers=3

-Daniel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
