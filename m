From: BRINER Cedric <briner@infomaniak.ch>
Subject: rc.autofs.in > getnismounts > error?
Date: Mon, 24 Nov 2003 12:00:44 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FC1E4DC.2070702@infomaniak.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: autofs@linux.kernel.org

hello,

I think that I've found a small mistake in the initialization script of=20
autofs-4.1.0.

in the function:
function getnismounts()
{
     YPMAP=3D`catnismap auto.master`
     if [ -z "$YPMAP" ]; then
        YPMAP=3D`catnismap`
     fi
     echo $YPMAP
}

The fact is that on my machine the line:
YPMAP=3D`catnismap auto.master`
remove the "\n" of what ""catnismap auto.master"" returns. And then the=20
read functions will not works and so on...

So in my case, I've simply changed the above function like this:
function getnismounts()
{
     YPMAP=3D`catnismap auto.master`
     if [ -z "$YPMAP" ]; then
        catnismap
     else
         catnismap auto.master
     fi
}
and everything works perflectly well.

Regards

C=C3=A9dric BRINER
PS. thanks for your work!

--=20

                    +41(o)\                       at
                           76/\    -o762   briner/  \infomaniak
                               577/     \ /                    \
  .       .       .   .  .  .  . -=3DCedric Briner=3D- .   . .ch - dot
                                        /
  46b rue Jacques-Dalphin,CH-1227 Geneva    \
