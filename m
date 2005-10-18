From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Tue, 18 Oct 2005 09:44:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0510180915020.8645@xena.cft.ca.us>
References: <200510181321.08443.krienke@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="163627976-1112954677-1129653859=:8645"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200510181321.08443.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--163627976-1112954677-1129653859=:8645
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 18 Oct 2005, Rainer Krienke wrote:

> using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4 
> kernel module, Kernel2.6.13-15) NFS mounts of user directories fail ...
> In auto.home there is this entry for each user like "krienke":  
>   
> krienke localhost:/import/user2/krienke  
>   
> In auto.vol you find another entry to handle the "user2" key starting at /import from above 
> (there are more than one nfsservers exporting user1, user2, ... each with about 2000 users):  
>   
> user2 nfssrv2:/export/user2  
> Oct 18 12:42:30 rzinstal1 automount[16793]: aquire_lock: can't lock lock file timed out: /var/lock/autofs 

Now that's a very neat solution to the problem of too many incoming / 
outgoing mounts.  But unfortunately you're doing the following sequence:

User refers to /home/krienke
    Autofs starts to mount /import/homesite/fsys/krienke, stats 
	/import/homesite/fsys
	Second autofs thread starts to mount homesite:/export/fsys
	    Oops, an autofs thread has the lock, 2nd thread either blocks
	    waiting for the lock, or dies.  (The latter, judging from
	    timestamps.)

The ideal is for autofs to avoid the deadlock by itself, but for a quick 
fix I'd put a programmatic map on /home which would do the NIS lookup by 
itself to ascertain which is the home site, would pre-mount 
/import/homesite/filesys (using the automounter, by statting the 
filesystem root), then would emit a map row pointing to the actual homedir.

I've attached my auto.net programmatic map.  Our issues are different from 
yours, but some of the issues are similar enough that portions of the 
program could be copied.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
--163627976-1112954677-1129653859=:8645
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="auto.net"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0510180944190.8645@xena.cft.ca.us>
Content-Description: 
Content-Disposition: attachment; filename="auto.net"

IyEvYmluL3NoDQojIEVxdWl2YWxlbnQgb2YgdGhlICJob3N0cyIgbWFwIG9u
IFN1bidzIGF1dG9tb3VudGVyLg0KIyBDb3B5cmlnaHQgKGMpIDIwMDEgYnkg
VGhlIFJlZ2VudHMgb2YgdGhlIFVuaXZlcnNpdHkgb2YgQ2FsaWZvcm5pYQ0K
IyBBdXRob3I6IEppbSBDYXJ0ZXIsIFVDTEEtTWF0aG5ldCA8amltY0BtYXRo
LnVjbGEuZWR1PiwgMjAwMS0wOC0yMw0KDQojIFRoaXMgaXMgYW4gZXhlY3V0
YWJsZSBtYXAgZmlsZSwgbW91bnRlZCBvbiAvbmV0LiAgV2hlbiB0aGUgYXV0
b21vdW50ZXINCiMgc2VlcyAvbmV0LyRob3N0L3Jlc3RvZi9wYXRoLCBpdCBy
dW5zIHRoaXMgc2NyaXB0IHdpdGggJDEgPSBob3N0bmFtZS4NCiMgVGhpcyBw
cm9ncmFtIGRvZXMgYXV0b21hZ2ljYWwgc2V0dXAsIHRoZW4gZW1pdHMgYSBt
YXAgbGluZSBkaXJlY3RpbmcNCiMgYXR0ZW50aW9uIHRvIC9yZXRlLyRob3N0
LCBvbiB3aGljaCBpdCBoYXMgbW91bnRlZCBhIHNlcGFyYXRlIGF1dG9tb3Vu
dA0KIyBwcm9jZXNzIHdoaWNoIHRha2VzIGl0IGZyb20gdGhlcmUuICBTaW5j
ZSB0aGUgcmVmZXJlbnQgaXMgb24gdGhlIGxvY2FsDQojIGhvc3QsIHRoZSAv
bmV0IGF1dG9tb3VudGVyIGVtaXRzIGEgc3ltYm9saWMgbGluayBvciBkb2Vz
IGEgImJpbmQiIG1vdW50LA0KIyB3aGljaCBpcyBlZmZpY2llbnQuDQoNCiMg
U3BlY2lmeSAtZCBmb3IgZGVidWcgbW9kZS4NCmlmIFsgWCQxICE9IFgtZCBd
IDsgdGhlbg0KCSMgSWYgeW91IHdhbnQgdG8gY3VzdG9taXplIHRoZSBuYW1l
IG9mIHRoZSBzZWNvbmRhcnkgbW91bnQgZGlyZWN0b3J5DQogICAgcmV0ZT0v
cmV0ZQ0KCSMgTWluaW11bSB0aW1lIGluIG1pbnV0ZXMgYmV0d2VlbiBwdXJn
aW5nIHVudXNlZCBob3N0IHByb2Nlc3Nlcw0KICAgIHB1cmdldGltZT02MA0K
CSMgYXV0b2Jhc2UgaXMgdGhlIGJhc2VuYW1lIG9mIHRoZSBhdXRvbW91bnQg
cHJvZ3JhbQ0KICAgIGF1dG9iYXNlPWF1dG9tb3VudA0KZWxzZQ0KICAgIHNo
aWZ0DQogICAgb3B0X2Q9REVCVUcNCiAgICByZXRlPS4vcmV0ZQ0KICAgIHB1
cmdldGltZT0xDQogICAgYXV0b2Jhc2U9c2xlZXANCmZpDQoNCiMgSWRpb3Rw
cm9vZiBmb3IgdGVzdGluZw0KaWYgWyAteiAiJDEiIF0gOyB0aGVuIA0KICAg
IGVjaG8gIlVzYWdlOiAkMCBob3N0bmFtZSAoaG9zdG5hbWUgcmVxdWlyZWQp
IiAxPiYyDQpmaQ0KDQoJCSMgUHVyZ2UgdW51c2VkIGhvc3Qtc3BlY2lmaWMg
bWFwIGZpbGVzLiAgVGhpcyBvY2N1cnMNCgkJIyBhdCBtb3N0IG9uY2UgYW4g
aG91ci4gIA0KCQkjIGZpbmQ6IC1tbWluIGlzIHRydWUgaWYgdGhlIGZpbGUn
cyBtdGltZSBpcyBOIG1pbnV0ZXMgb2xkLg0Kc3RhbXA9YGZpbmQgJHJldGUv
VElNRVNUQU1QIC1tbWluIC0kcHVyZ2V0aW1lIC1wcmludCAyPiAvZGV2L251
bGxgDQppZiBbIC16ICIkc3RhbXAiIF0gOyB0aGVuDQoJbWtkaXIgJHJldGUv
S0VFUA0KCWZvciBmIGluIC9uZXQvKiA7IGRvDQoJICAgIGJuPWBiYXNlbmFt
ZSAkZmANCgkgICAgaWYgWyAtZiAiJHJldGUvJGJuIiBdIDsgdGhlbiBtdiAi
JHJldGUvJGJuIiAkcmV0ZS9LRUVQIDsgZmkNCglkb25lDQoJcm0gLWYgJHJl
dGUvW2Etel0qDQoJbXYgJHJldGUvS0VFUC8qICRyZXRlIDI+IC9kZXYvbnVs
bA0KCXJtZGlyICRyZXRlL0tFRVANCiAgICBkYXRlICIraG9zdCBtYXAgZmls
ZXMgbGFzdCBwdXJnZWQgYXQgJVktJW0tJWQgJUg6JU06JVMiID4gJHJldGUv
VElNRVNUQU1QDQpmaQ0KDQoJCSMgQ3JlYXRlIG1hcCBmaWxlIGZvciB0aGUg
aG9zdC1zcGVjaWZpYyBhdXRvbW91bnQgcHJvY2Vzcy4NCmVjaG8gIioJJDE6
LyYiID4gJHJldGUvJDEgDQoNCgkJIyBFbWl0IG1hcCByb3cgdG8gY2F1c2Ug
YW4gYXV0b2ZzIHN1Ym1vdW50IHRvIGJlIHNwYXduZWQuDQoJCSMgUmVzdWx0
aW5nIGNvbW1hbmQgbGluZSBpczoNCgkJIyAvdXNyL3NiaW4vYXV0b21vdW50
IC0tc3VibW91bnQgL25ldC8kMSBmaWxlICRyZXRlLyQxDQoJCSMgZm9sbG93
ZWQgYnkgbWFwIG9wdGlvbnMgaWYgYW55IHdlcmUgc3BlY2lmaWVkLg0KZWNo
byAiLXJzaXplPTgxOTIsd3NpemU9ODE5MixyZXRyeT0xLHNvZnQsZnN0eXBl
PWF1dG9mcwlmaWxlOiRyZXRlLyQxIg0KZXhpdCAwDQo=

--163627976-1112954677-1129653859=:8645
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--163627976-1112954677-1129653859=:8645--

