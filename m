From: jmoyer@redhat.com
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Tue, 21 Nov 2006 14:13:52 -0500
Message-ID: <m3mz6ky5n3.fsf@redhat.com>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B39@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B39@catoexm05.noam.corp.platform.com>
	(Shawn Starr's message of "Tue, 21 Nov 2006 13:58:53 -0500")
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
To: Shawn Starr <sstarr@platform.com>
Cc: autofs@linux.kernel.org

==> Regarding RE: [autofs] Automount with a local NFS export and a remote NFS export using the same mount path name over LDAP; "Shawn Starr" <sstarr@platform.com> adds:

sstarr> Hi Jeff, This didn't work on RHEL4 U4.

sstarr> It again skipped mounting the remote LDAP NFS map.

sstarr> It is clobbering the two NFS exports sharing /home

sstarr> I noticed you made a patch this month for LDAP and automount, that
sstarr> seems to be what I'm trying to do.

sstarr> basically, If my nssswitch.conf has: automount: files ldap

sstarr> Automount should respect *both* file and LDAP automounts. Right now
sstarr> only one is expected Even If I use the option you mentioned below.

I re-read your original problem statement, and I am officially confused.
What, exactly, are you trying to accomplish?

Do you want to merge the contents of two master maps?  If so, set
ONE_AUTO_MASTER=0.

Do you want to merge the contents of two indirect maps?  If so, try reading
up on multi-maps.  This allows one to merge the contents of two or more
maps, potentially from different sources.

If neither of these is what you are trying to do, then please provide a
better explanation of the problem.  Post your maps, and give concrete
examples with machine names, exports, and intended use.

-Jeff
