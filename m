From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: multi-level auto.master in ldap
Date: Tue, 17 Aug 2010 22:56:20 +0200
Message-ID: <hbf.20100817t0bg@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

How do I translate this (in particular auto.master) to autofs-ldap?

auto.master mount pt	Description in indirect map
  /X/A                	* -options...  A.example.com:/x/a/&
  /X/B			* -options...  B.example.com:/x/b/&
  /Y/B			* -options...  B.example.com:/y/b/&

The HOWTOs I've seen do not put /X and /Y in the DN, thus
they give the same DN to /X/B and /Y/B:

  DN of 'automount' object	automountInformation attribute
  cn=/X,ou=auto.master,$suffix	ldap:ou=auto.X,$suffix
  cn=B ,ou=auto.X,$suffix	-fstype=autofs ldap:ou=auto.B,$suffix
  cn=/ ,ou=auto.B,$suffix	B.example.com:/x/b/&

So, what should I call the final object - "cn=/,ou=auto.B.X,$suffix"?
Is there some significance to the auto.* ou names, except auto.master?
For that matter, I'm in any case wondering why people seem to be using
a single auto.* namespace for both directory components and hosts.

-- 
Hallvard
