From: "Daniel Richard G." <skunk@iskunk.org>
Subject: AFS + LDAP
Date: Thu, 6 Jul 2006 01:50:29 -0400
Message-ID: <20060706055029.GS19585@mail.iSKUNK.ORG>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Does there exist a standard(ish) LDAP schema for AFS mounts?

I'm familiar with the Hesiod record format, along the lines of e.g.

	AFS /afs/athena.mit.edu/contrib/sipb n /mit/sipb 1
	AFS /afs/athena.mit.edu/user/y/o/yoav w /mit/yoav

(and supported by the Hesiod lookup module), but I'm interested in pulling 
this same sort of information via LDAP.


Any hints/pointers would be appreciated,


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
