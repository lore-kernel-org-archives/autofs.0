From: Hans Deragon <hans@deragon.biz>
Subject: backfstype patch.
Date: Fri, 16 Jul 2004 14:45:28 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40F82248.2050803@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Greetings.


   Remember me with my backfstype patch?  Some people commented on it, I replied 
and then never got any answers since.  Altough functional, my patch was 
questionned; the fix was not at the right place within the code (from a 
design/elegance point of view; technically it works great).  As I explained, I 
have no knowledge of the overall architecture of Autofs and unfortunatly, I do 
not have the time to get deep into it.

   Can my patch still be applied in the main branch until it is moved into a 
more appropriate area of the code?  Its still adds the new backsftype support, 
does not cause any problems, is very localized, and very usefull.  I have been 
running it since the last 2 weeks without any problems.  I am rolling it out in 
the production environment.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
