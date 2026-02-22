import gsap from "gsap"
import { ScrollTrigger, SplitText } from "gsap/all"

gsap.registerPlugin(ScrollTrigger, SplitText)

const App = () => {
  return (
    <div className="text-3xl text-indigo-300 flex-center h-[100vh]"><h1>App</h1></div>
  )
}
export default App