From: Hunter Matthews <thm@duke.edu>
Subject: chained configs (and ghost too)
Date: 15 Mar 2004 14:56:47 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1079380607.4327.59.camel@jade.biology.duke.edu>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@linux.kernel.org>

All, Thanks to nalin and steve, I've gotten autofs working with LDAP. 

I haven't seen this in the docs, nor in my quick scan of the archives.
So, for others wondering how, here is the working configuration:

In nis, I had a table called auto.biology: 
groups -fstype=autofs  yp:auto.groups
zzz balh:/local/zzz
ftp ftp:/local/ftp
....

All of these are now working fine from LDAP. I used  

# groups, auto.biology, nis, biology, duke, edu
dn: cn=groups,nisMapName=auto.biology,ou=nis,dc=biology,dc=duke,dc=edu
objectClass: nisObject
cn: groups
nisMapName: auto.biology
nisMapEntry: -fstype=autofs ldap:nisMapName=auto.groups,ou=nis,dc=biology,dc=duke,dc=edu --ti
 meout 300 --ghost rsize=16384,wsize=16384

auto.groups is then a normal automount map, same as any other.

In my server, I have all the nisMaps at the same level in the ldap 
server. I did not try having the auto.group map be below the 
auto.biology tree - they are both at the top level of the ou where 
I'm keeping nis type info.

If you don't have the '-fstype=autofs' part first, it won't work, and
in your logs you will see: 

Mar 15 14:21:58 greenback automount[23607]: mount(nfs): nfs: mount
failure ldap:nisMapName=auto.groups,ou=nis,dc=biology,dc=duke,dc=edu on
/biology/groups

I've not followed all the "umount" trouble thread, but these are
unmounting about when they should. I'm not running nautilus though...


-- 
Hunter Matthews                          Unix / Network Administrator
Office: BioScience 145/244               Duke Univ. Biology Department
Key: F0F88438 / FFB5 34C0 B350 99A4 BB02  9779 A5DB 8B09 F0F8 8438
Never take candy from strangers. Especially on the internet.
